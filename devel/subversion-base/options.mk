# $NetBSD: options.mk,v 1.4 2008/03/08 20:56:37 gdt Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.subversion
PKG_SUPPORTED_OPTIONS=	apache22 apr1 serf
PKG_SUGGESTED_OPTIONS=	apr1

# Note that this file is included as part of several packages.
# Therefore this file only defines options, but does not include the
# typical fragments to change behavior based on options, leaving those
# to the individual Makefiles.

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mapache22) || !empty(PKG_OPTIONS:Mserf)
PKG_OPTIONS+=		apr1
.endif

# Why is this here?  apache22 is not used
.if !empty(PKG_OPTIONS:Mapr1) && empty(PKG_OPTIONS:Mapache22)
PKG_OPTIONS+=		apache22
.endif
