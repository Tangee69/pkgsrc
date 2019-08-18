#! @PERL@
# $NetBSD: url2pkg.pl,v 1.51 2019/08/18 06:41:16 rillig Exp $
#

# Copyright (c) 2010 The NetBSD Foundation, Inc.
# All rights reserved.
#
# This code is derived from software contributed to The NetBSD Foundation
# by Roland Illig.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

use feature qw{ switch };
use strict;
use warnings;

#
# Build-time Configuration.
#

my $make		= '@MAKE@';
my $perllibdir		= '@PERLLIBDIR@';

use constant true	=> 1;
use constant false	=> 0;

#
# Some helper subroutines.
#

sub run_editor($$) {
	my ($fname, $lineno) = @_;

	my $editor = $ENV{"PKGEDITOR"} || $ENV{"EDITOR"} || "vi";

	my @args;
	push(@args, $editor);
	push(@args, "+$lineno") if $editor =~ qr"(^|/)(mcedit|nano|pico|vi|vim)$";
	push(@args, $fname);

	system { $args[0] } (@args);
}

sub get_maintainer() {

	return $ENV{"PKGMAINTAINER"} || $ENV{"REPLYTO"} || "INSERT_YOUR_MAIL_ADDRESS_HERE";
}

sub var($$$) {
	my ($name, $op, $value) = @_;

	return [$name, $op, $value];
}

sub add_section($$) {
	my ($lines, $vars) = @_;

	return if scalar(@$vars) == 0;

	my $width = 0;
	foreach my $var (@{$vars}) {
		my ($name, $op, $value) = @$var;
		next if $value eq "";
		my $len = (length("$name$op\t") + 7) & -8;
		$width = ($len > $width) ? $len : $width;
	}

	foreach my $var (@{$vars}) {
		my ($name, $op, $value) = @$var;
		next if $value eq "";
		my $tabs = "\t" x (($width - length("$name$op") + 7) / 8);
		push(@$lines, "$name$op$tabs$value");
	}
	push(@$lines, "");
}

# The following magic_* subroutines are called after the distfiles have
# been downloaded and extracted. They inspect the extracted files
# to automatically define some variables in the package Makefile.
#
# The following variables may be used in the magic_* subroutines:
#
# $distname
#	contains the package name, including the version number.
# $abs_wrkdir
#	the absolute pathname to the working directory, containing
#	the extracted distfiles.
# $abs_wrksrc
#	the absolute pathname to a subdirectory of $abs_wrkdir,
#	typically containing package-provided Makefiles or configure
#	scripts.
#
# The following lists may be extended by the magic_* routines and
# will later appear in the package Makefile:
#
# @depends
# @build_depends
#	the dependencies of the package, in the form
#	"package>=version:../../category/package".
# @includes
#	a list of pathnames relative to the package path.
#	All these files will be included at the bottom of the Makefile.
# @build_vars
#	a list of variable assignments that will make up the fourth
#	paragraph of the package Makefile, where the build configuration
#	takes place.
# @extra_vars
#	similar to the @build_vars, but separated by an empty line in
#	the Makefile, thereby forming the fifth paragraph.
# @todos
#	these are inserted below the second paragraph in the Makefile.

my ($distname, $abs_wrkdir, $abs_wrksrc);
my (@wrksrc_files, @wrksrc_dirs);
my (@depends, @build_depends, @includes, @build_vars, @extra_vars, @todos);
my ($pkgname);

#
# And now to the real magic_* subroutines.
#

sub magic_configure() {
	my $gnu_configure = false;

	open(CONF, "<", "${abs_wrksrc}/configure") or return;
	while (defined(my $line = <CONF>)) {
		if ($line =~ qr"autoconf|Free Software Foundation"i) {
			$gnu_configure = true;
			last;
		}
	}
	close(CONF);

	my $varname = ($gnu_configure ? "GNU_CONFIGURE" : "HAS_CONFIGURE");
	push(@build_vars, var($varname, "=", "yes"));
}

sub magic_cmake() {
	open(CONF, "<", "${abs_wrksrc}/CMakeLists.txt") or return;
	close(CONF);

	push(@build_vars, var("USE_CMAKE", "=", "yes"));
}

sub magic_meson() {
	open(CONF, "<", "${abs_wrksrc}/meson.build") or return;
	close(CONF);

	push(@includes, "../../devel/py-meson/build.mk");
}

sub magic_gconf2_schemas() {
	my @gconf2_files = grep(/schemas(?:\.in.*)$/, @wrksrc_files);
	if (@gconf2_files) {
		foreach my $f (@gconf2_files) {
			if ($f =~ qr"(.*schemas)") {
				push(@extra_vars, var("GCONF_SCHEMAS", "+=", $1));
			}
		}
		push(@includes, "../../devel/GConf/schemas.mk");
	}
}

sub magic_libtool() {
	if (-f "${abs_wrksrc}/ltconfig" || -f "${abs_wrksrc}/ltmain.sh") {
		push(@build_vars, var("USE_LIBTOOL", "=", "yes"));
	}
	if (-d "${abs_wrksrc}/libltdl") {
		push(@includes, "../../devel/libltdl/convenience.mk");
	}
}

sub magic_perlmod() {
	if (-f "${abs_wrksrc}/Build.PL") {

		# It's a Module::Build module. Dependencies cannot yet be
		# extracted automatically.
		push(@todos, "Look for the dependencies in Build.PL.");

		push(@build_vars, var("PERL5_MODULE_TYPE", "=", "Module::Build"));

	} elsif (-f "${abs_wrksrc}/Makefile.PL") {

		# To avoid fix_up_makefile error for p5-HTML-Quoted, generate Makefile first.
		system("cd ${abs_wrksrc} && perl -I. Makefile.PL < /dev/null") or do {};

		open(DEPS, "cd ${abs_wrksrc} && perl -I${perllibdir} -I. Makefile.PL |") or die;
		while (defined(my $dep = <DEPS>)) {
			chomp($dep);
			if ($dep =~ qr"\.\./\.\./") {
				# Many Perl modules write other things to
				# stdout, so filter them out.
				push(@depends, $dep);
			}
		}
		close(DEPS) or die;

	} else {
		return;
	}

	my $packlist = $distname;
	$packlist =~ s/-[0-9].*//;
	$packlist =~ s/-/\//g;
	push(@build_vars, var("PERL5_PACKLIST", "=", "auto/${packlist}/.packlist"));
	push(@includes, "../../lang/perl5/module.mk");
	$pkgname = "p5-\${DISTNAME}";
}

sub magic_cargo() {
	open(CONF, "<", "${abs_wrksrc}/Cargo.lock") or return;

	while (defined(my $line = <CONF>)) {
		# "checksum cargo-package-name cargo-package-version
		if ($line =~ m/("checksum)\s(\S+)\s(\S+)/) {
			push(@build_vars, var("CARGO_CRATE_DEPENDS", "=", "$2-$3"));
		}
	}
	close(CONF);

	push(@includes, "../../lang/rust/cargo.mk");
}


sub magic_pkg_config() {
	my @pkg_config_files = grep { /\.pc\.in$/ && ! /-uninstalled\.pc\.in$/ } @wrksrc_files;
	if (@pkg_config_files) {
		push(@build_vars, var("USE_TOOLS", "+=", "pkg-config"));
	}
	foreach my $f (@pkg_config_files) {
		push(@extra_vars, var("PKGCONFIG_OVERRIDE", "+=", $f));
	}
}

sub magic_po() {
	if (grep(/\.g?mo$/, @wrksrc_files)) {
		push(@build_vars, var("USE_PKGLOCALEDIR", "=", "yes"));
	}
}

sub magic_use_languages() {
	my @languages;

	grep(/\.(c|xs)$/, @wrksrc_files) and push(@languages, "c");
	grep(/\.(cpp|c\+\+|cxx|cc|C)$/, @wrksrc_files) and push(@languages, "c++");
	grep(/\.f$/, @wrksrc_files) and push(@languages, "fortran");

	my $use_languages = join(" ", @languages);
	if ($use_languages eq "") {
		$use_languages = "# none";
	}
	if ($use_languages ne "c") {
		push(@build_vars, var("USE_LANGUAGES", "=", $use_languages));
	}
}

#
# Subroutines for generating the initial package and adjusting it after
# the distfiles have been extracted.
#

sub generate_initial_package_Makefile($) {
	my ($url) = @_;

	my $master_site = "";
	my $master_sites = "";
	my $distfile = "";
	my $homepage = "";
	my $extract_sufx = "";
	my $categories = "";
	my $github_project = "";
	my $github_release = "";
	my $dist_subdir = "";

	my $found = false;
	open(SITES, "<", "../../mk/fetch/sites.mk") or die;
	while (defined(my $line = <SITES>)) {
		chomp($line);

		if ($line =~ qr"^(MASTER_SITE_.*)\+=") {
			$master_site = $1;

		} elsif ($line =~ qr"^\t(.*?)(?:\s+\\)?$") {
			my ($site) = ($1);

			if (index($url, $site) == 0) {
				$found = true;

				if ($url =~ qr"^\Q${site}\E(.+)/([^/]+)$") {
					my $subdir = $1;
					$distfile = $2;

					$master_sites = "\${${master_site}:=${subdir}/}";
					if ($master_site eq "MASTER_SITE_SOURCEFORGE") {
						$homepage = "http://${subdir}.sourceforge.net/";
					} elsif ($master_site eq "MASTER_SITE_GNU") {
						$homepage = "http://www.gnu.org/software/${subdir}/";
					} else {
						$homepage = substr($url, 0, -length($distfile));
					}
				} else {
					$master_sites = "\${${master_site}}";
				}
			}
		}
	}
	close(SITES) or die;

	if ($url =~ qr"^http://(?:pr)?downloads\.sourceforge\.net/([^/]*)/([^/?]+)(?:\?(?:download|use_mirror=.*))?$") {
		my $pkgbase = $1;
		$distfile = $2;

		$master_sites = "\${MASTER_SITE_SOURCEFORGE:=${pkgbase}/}";
		$homepage = "http://${pkgbase}.sourceforge.net/";
		$found = true;
	}

	if ($url =~ qr"^https?://github\.com/") {
		if ($url =~ qr"^https?://github\.com/(.*)/(.*)/archive/(.*)(\.tar\.gz|\.zip)$") {
			my ($org, $proj, $tag, $ext) = ($1, $2, $3, $4);

			$master_sites = "\${MASTER_SITE_GITHUB:=$org/}";
			$homepage = "https://github.com/$org/$proj/";
			$github_project = $proj;
			if (index($tag, $github_project) == -1) {
				$pkgname = '${GITHUB_PROJECT}-${DISTNAME}';
				$dist_subdir = '${GITHUB_PROJECT}';
			}
			$distfile = "$tag$ext";
			$found = true;

		} elsif ($url =~ qr"^https?://github\.com/(.*)/(.*)/releases/download/(.*)/(.*)(\.tar\.gz|\.zip)$") {
			my ($org, $proj, $tag, $base, $ext) = ($1, $2, $3, $4, $5);

			$master_sites = "\${MASTER_SITE_GITHUB:=$org/}";
			$homepage = "https://github.com/$org/$proj/";
			if (index($base, $proj) == -1) {
				$github_project = $proj;
				$dist_subdir = '${GITHUB_PROJECT}';
			}
			$github_release = $tag eq $base ? '${DISTNAME}' : $tag;
			$distfile = "$base$ext";
			$found = true;
		} else {
			print("$0: ERROR: Invalid GitHub URL: ${url}, handling as normal URL\n");
		}
	}

	if (!$found) {
		if ($url =~ qr"^(.*/)(.*)$") {
			($master_sites, $distfile) = ($1, $2);
			$homepage = $master_sites;
		} else {
			die("$0: ERROR: Invalid URL: ${url}\n");
		}
	}

	if ($distfile =~ qr"^(.*?)((?:\.tar)?\.\w+)$") {
		($distname, $extract_sufx) = ($1, $2);
	} else {
		($distname, $extract_sufx) = ($distfile, "# none");
	}

	rename("Makefile", "Makefile-url2pkg.bak") or do {};

	`pwd` =~ qr".*/([^/]+)/[^/]+$" or die;
	$categories = $1;

	if ($extract_sufx eq ".tar.gz" || $extract_sufx eq ".gem") {
		$extract_sufx = "";
	}

	my @lines;
	push(@lines, "# \$" . "NetBSD\$");
	push(@lines, "");

	add_section(\@lines, [
		var("GITHUB_PROJECT", "=", $github_project),
		var("DISTNAME", "=", $distname),
		var("CATEGORIES", "=", $categories),
		var("MASTER_SITES", "=", $master_sites),
		var("GITHUB_RELEASE", "=", $github_release),
		var("EXTRACT_SUFX", "=", $extract_sufx),
		var("DIST_SUBDIR", "=", $dist_subdir),
	]);

	add_section(\@lines, [
		var("MAINTAINER", "=", get_maintainer()),
		var("HOMEPAGE", "=", $homepage),
		var("COMMENT", "=", "TODO: Short description of the package"),
		var("#LICENSE", "=", "# TODO: (see mk/license.mk)"),
	]);

	push(@lines, "# url2pkg-marker (please do not remove this line.)");
	push(@lines, ".include \"../../mk/bsd.pkg.mk\"");

	open(MF, ">", "Makefile") or die;
	foreach my $line (@lines) {
		print MF "$line\n";
	}
	close(MF) or die;
}

sub generate_initial_package($) {
	my ($url) = @_;

	generate_initial_package_Makefile($url);

	open(PLIST, ">", "PLIST") or die;
	print PLIST ("\@comment \$" . "NetBSD\$\n");
	close(PLIST) or die;

	open(DESCR, ">", "DESCR") or die;
	close(DESCR) or die;

	run_editor("Makefile", 5);

	print ("url2pkg> Running \"make distinfo\" ...\n");
	(system { $make } ($make, "distinfo")) == 0 or die;

	print ("url2pkg> Running \"make extract\" ...\n");
	(system { $make } ($make, "extract")) == 0 or die;
}

sub adjust_package_from_extracted_distfiles()
{
	my ($seen_marker);

	chomp($abs_wrkdir = `${make} show-var VARNAME=WRKDIR`);

	#
	# Determine the value of WRKSRC.
	#
	my @files = ();
	opendir(WRKDIR, $abs_wrkdir) or die;
	while (defined(my $f = readdir(WRKDIR))) {
		no if $] >= 5.018, warnings => "experimental::smartmatch";
		given ($f) {
			next when qr"^\.";
			next when 'pax_global_header';
			next when 'package.xml';
			next when qr".*\.gemspec";
			default { push(@files, $f) }
		}
	}
	closedir(WRKDIR);
	if (@files == 1) {
		if ($files[0] ne $distname) {
			push(@build_vars, var("WRKSRC", "=", "\${WRKDIR}/$files[0]"));
		}
		$abs_wrksrc = "${abs_wrkdir}/$files[0]";
	} else {
		push(@build_vars, var("WRKSRC", "=", "\${WRKDIR}" .
		    ((@files > 1) ? " # More than one possibility -- please check manually." : "")));
		$abs_wrksrc = $abs_wrkdir;
	}

	chomp(@wrksrc_files = `cd "${abs_wrksrc}" && find * -type f`);
	chomp(@wrksrc_dirs = `cd "${abs_wrksrc}" && find * -type d`);

	magic_configure();
	magic_cmake();
	magic_meson();
	magic_gconf2_schemas();
	magic_libtool();
	magic_perlmod();
	magic_cargo();
	magic_pkg_config();
	magic_po();
	magic_use_languages();

	print("url2pkg> Adjusting the Makefile.\n");

	my @lines;

	open(MF1, "<", "Makefile") or die;

	# Copy the user-edited part of the Makefile.
	while (defined(my $line = <MF1>)) {
		chomp($line);

		if ($line =~ qr"^# url2pkg-marker\b") {
			$seen_marker = true;
			last;
		}
		push(@lines, $line);

		if (defined($pkgname) && $line =~ qr"^DISTNAME=(\t+)") {
			push(@lines, "PKGNAME=$1$pkgname");
		}
	}

	if (@todos) {
		foreach my $todo (@todos) {
			push(@lines, "# TODO: $todo");
		}
		push(@lines, "");
	}

	my @depend_vars;
	foreach my $dep (@build_depends) {
		push(@depend_vars, var("BUILD_DEPENDS", "+=", $dep));
	}
	foreach my $dep (@depends) {
		push(@depend_vars, var("DEPENDS", "+=", $dep));
	}
	add_section(\@lines, \@depend_vars);

	add_section(\@lines, \@build_vars);
	add_section(\@lines, \@extra_vars);

	foreach my $f (@includes) {
		push(@lines, ".include \"$f\"");
	}

	# Copy the rest of the user-edited part of the Makefile.
	while (defined(my $line = <MF1>)) {
		chomp($line);
		push(@lines, $line);
	}

	close(MF1);

	open(MF2, ">", "Makefile-url2pkg.new") or die;
	foreach my $line (@lines) {
		print MF2 "$line\n";
	}
	close(MF2) or die;

	if ($seen_marker) {
		rename("Makefile-url2pkg.new", "Makefile") or die;
	} else {
		unlink("Makefile-url2pkg.new");
		die("$0: ERROR: didn't find the url2pkg marker in the file.\n");
	}
}

sub main() {
	my $url;

	if (!-f "../../mk/bsd.pkg.mk") {
		die("ERROR: $0 must be run from a package directory (.../pkgsrc/category/package).\n");
	}

	my @extract_cookie = <w*/.extract_done>;
	if (scalar(@extract_cookie) == 0) {
		if (scalar(@ARGV) == 0) {
			print("URL: ");
			# Pressing Ctrl-D is considered equivalent to
			# aborting the process.
			if (!defined($url = <STDIN>)) {
				print("\n");
				print("No URL given -- aborting.\n");
				exit(0);
			}
		} else {
			$url = shift(@ARGV);
		}

		generate_initial_package($url);
	} else {
		chomp($distname = `${make} show-var VARNAME=DISTNAME`);
	}

	adjust_package_from_extracted_distfiles();

	print("\n");
	print("Remember to correct CATEGORIES, HOMEPAGE, COMMENT, and DESCR when you're done!\n");
	print("\n");
	print("Good luck! (See pkgsrc/doc/pkgsrc.txt for some more help :-)\n");
}

main();
