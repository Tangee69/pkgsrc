# -*- perl -*-
# $NetBSD: url2pkg.t,v 1.8 2019/09/12 04:18:28 rillig Exp $

require "url2pkg.pl";

use Test::More;

use strict;
use warnings;

sub test_lines_add_vars__simple() {
	my $lines = [];

	lines_add_vars($lines, [
		var("1", "=", "one"),
		var("6", "=", "six"),
	]);

	is_deeply($lines, [
		"1=\tone",
		"6=\tsix",
		"",
	]);
}

sub test_lines_add_vars__alignment() {
	my $lines = [];

	lines_add_vars($lines, [
		var("short", "=", "value"),
		var("long_name", "=", "value # comment"),
	]);

	is_deeply($lines, [
		"short=\t\tvalue",
		"long_name=\tvalue # comment",
		"",
	]);
}

sub test_lines_add_vars__operators() {
	my $lines = [];

	lines_add_vars($lines, [
		var("123456", "+=", "value"),
	]);

	is_deeply($lines, [
		"123456+=\tvalue",
		"",
	]);
}

sub test_lines_append__not_found() {
	my $lines = [];

	lines_append($lines, "VARNAME", "value");

	is_deeply($lines, []);
}

sub test_lines_append__only_comment() {
	my $lines = ["VARNAME=\t\t\t# none"];

	lines_append($lines, "VARNAME", "value");

	is_deeply($lines, ["VARNAME=\t\t\tvalue # none"]);
}

sub test_lines_append__value_with_comment() {
	my $lines = ["VARNAME=\tvalue # comment"];

	lines_append($lines, "VARNAME", "appended");

	is_deeply($lines, ["VARNAME=\tvalue appended # comment"]);
}

sub test_lines_append__value_without_comment() {
	my $lines = ["VARNAME+=\tvalue"];

	lines_append($lines, "VARNAME", "appended");

	is_deeply($lines, ["VARNAME+=\tvalue appended"]);
}

sub test_generate_initial_package_Makefile_lines__GitHub_archive() {
	my $url = "https://github.com/org/proj/archive/v1.0.0.tar.gz";

	my @lines = generate_initial_package_Makefile_lines($url);

	is_deeply(\@lines, [
		"# \$" . "NetBSD\$",
		"",
		"GITHUB_PROJECT=\tproj",
		"DISTNAME=\tv1.0.0",
		"CATEGORIES=\tpkgtools",
		"MASTER_SITES=\t\${MASTER_SITE_GITHUB:=org/}",
		"DIST_SUBDIR=\t\${GITHUB_PROJECT}",
		"",
		"MAINTAINER=\tINSERT_YOUR_MAIL_ADDRESS_HERE",
		"HOMEPAGE=\thttps://github.com/org/proj/",
		"COMMENT=\tTODO: Short description of the package",
		"#LICENSE=\t# TODO: (see mk/license.mk)",
		"",
		"# url2pkg-marker (please do not remove this line.)",
		".include \"../../mk/bsd.pkg.mk\""
	]);
}

sub test_generate_initial_package_Makefile_lines__GitHub_release_containing_project_name() {
	my $url = "https://github.com/org/proj/releases/download/1.0.0/proj.zip";

	my @lines = generate_initial_package_Makefile_lines($url);

	is_deeply(\@lines, [
		"# \$" . "NetBSD\$",
		"",
		"DISTNAME=\tproj",
		"CATEGORIES=\tpkgtools",
		"MASTER_SITES=\t\${MASTER_SITE_GITHUB:=org/}",
		"GITHUB_RELEASE=\t1.0.0",
		"EXTRACT_SUFX=\t.zip",
		"",
		"MAINTAINER=\tINSERT_YOUR_MAIL_ADDRESS_HERE",
		"HOMEPAGE=\thttps://github.com/org/proj/",
		"COMMENT=\tTODO: Short description of the package",
		"#LICENSE=\t# TODO: (see mk/license.mk)",
		"",
		"# url2pkg-marker (please do not remove this line.)",
		".include \"../../mk/bsd.pkg.mk\""
	]);
}

sub test_generate_initial_package_Makefile_lines__GitHub_release_not_containing_project_name() {
	my $url = "https://github.com/org/proj/releases/download/1.0.0/data.zip";

	my @lines = generate_initial_package_Makefile_lines($url);

	is_deeply(\@lines, [
		"# \$" . "NetBSD\$",
		"",
		"GITHUB_PROJECT=\tproj",
		"DISTNAME=\tdata",
		"CATEGORIES=\tpkgtools",
		"MASTER_SITES=\t\${MASTER_SITE_GITHUB:=org/}",
		"GITHUB_RELEASE=\t1.0.0",
		"EXTRACT_SUFX=\t.zip",
		"DIST_SUBDIR=\t\${GITHUB_PROJECT}",
		"",
		"MAINTAINER=\tINSERT_YOUR_MAIL_ADDRESS_HERE",
		"HOMEPAGE=\thttps://github.com/org/proj/",
		"COMMENT=\tTODO: Short description of the package",
		"#LICENSE=\t# TODO: (see mk/license.mk)",
		"",
		"# url2pkg-marker (please do not remove this line.)",
		".include \"../../mk/bsd.pkg.mk\""
	]);
}

sub test_read_dependencies() {
	my $cmd = "printf '%s\n' \"\$URL2PKG_DEPENDENCIES\"";
	my @dep_lines = (
		"DEPENDS\tpackage>=version:../../pkgtools/pkglint",
		"DEPENDS\tpackage>=version:../../pkgtools/x11-links",
		"BUILD_DEPENDS\turl2pkg>=1.0",
		"TEST_DEPENDS\tpkglint",
		"A line that is not a dependency at all",
		""
	);
	my $env = { "URL2PKG_DEPENDENCIES" => join("\n", @dep_lines) };

	read_dependencies($cmd, $env, "");

	is($ENV{"URL2PKG_DEPENDENCIES"}, undef);
	is_deeply(\@main::depends, [
		"package>=version:../../pkgtools/pkglint"
	]);
	is_deeply(\@main::bl3_lines, [
		".include \"../../pkgtools/x11-links/buildlink3.mk\""
	]);
	is_deeply(\@main::build_depends, [
		"url2pkg>=1.0:../../pkgtools/url2pkg"
	]);
	is_deeply(\@main::test_depends, [
		"pkglint>=0:../../pkgtools/pkglint"
	]);
}

sub set_up_test() {
	@main::depends = ();
	@main::build_depends = ();
	@main::test_depends = ();
	@main::bl3_lines = ();
}

sub t_main() {
	my $pkgsrcdir = $ENV{"PKGSRCDIR"} or die;
	chdir("$pkgsrcdir/pkgtools/url2pkg") or die;

	no strict 'refs';
	foreach my $testname (sort grep { $_ =~ qr"^test_" } keys %{"main::"}) {
		next if $testname eq "test_depends";  # it's an array
		set_up_test();
		&{"main::$testname"}();
	}

	done_testing();
}

t_main();
