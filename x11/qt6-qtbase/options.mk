# $NetBSD: options.mk,v 1.3 2023/08/03 20:01:29 adam Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.qt6-qtbase
PKG_SUPPORTED_OPTIONS+=	gtk3

.include "../../mk/bsd.fast.prefs.mk"

.if ${OPSYS} != "Darwin"
PKG_SUPPORTED_OPTIONS+=	cups dbus
PKG_SUGGESTED_OPTIONS+=	cups dbus
.endif

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		cups dbus gtk3

.if !empty(PKG_OPTIONS:Mcups)
.  include "../../print/libcups/buildlink3.mk"
CONFIGURE_ARGS+=	-cups
PLIST.cups=		yes
.else
CONFIGURE_ARGS+=	-no-cups
.endif

.if !empty(PKG_OPTIONS:Mdbus)
# Use lib/dbus-1.0/include/dbus/dbus-arch-deps.h from sysutils/dbus
USE_DBUS-ARCH-DEPS_H=	yes
.include "../../devel/at-spi2-core/buildlink3.mk"
.include "../../sysutils/dbus/buildlink3.mk"
CONFIGURE_ARGS+=	-dbus-linked
PLIST.dbus=		yes
PKGCONFIG_OVERRIDE+=	lib/pkgconfig/Qt6DBus.pc
.else
CONFIGURE_ARGS+=	-no-dbus
.endif

.if !empty(PKG_OPTIONS:Mgtk3)
.  include "../../x11/gtk3/buildlink3.mk"
CONFIGURE_ARGS+=	-gtk
PLIST.gtk3=		yes
.else
CONFIGURE_ARGS+=	-no-gtk
.endif
