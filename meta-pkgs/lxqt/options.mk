# $NetBSD: options.mk,v 1.6 2024/11/27 10:28:36 pin Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.lxqt
PKG_OPTIONS_OPTIONAL_GROUPS=	wm
PKG_OPTIONS_GROUP.wm=		openbox xfce4-wm
PKG_SUGGESTED_OPTIONS=		openbox

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mopenbox)
DEPENDS+=	openbox>=3.6.1:../../wm/openbox
DEPENDS+=	obconf-qt>=0.16.5:../../wm/obconf-qt
.endif

.if !empty(PKG_OPTIONS:Mxfce4-wm)
DEPENDS+=	xfce4-wm>=4.14.6:../../wm/xfce4-wm
.endif
