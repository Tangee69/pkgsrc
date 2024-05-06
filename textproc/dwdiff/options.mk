# $NetBSD: options.mk,v 1.1 2024/05/06 10:42:51 cheusov Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.dwdiff

PKG_SUPPORTED_OPTIONS=	nls
PKG_SUGGESTED_OPTIONS=	nls

PLIST_VARS+=		nls

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mnls)
USE_TOOLS+=		msgfmt msgmerge xgettext
PLIST.nls=		yes
.else
CONFIGURE_ARGS+=	--without-gettext
.endif
