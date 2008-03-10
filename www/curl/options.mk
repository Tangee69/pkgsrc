# $NetBSD: options.mk,v 1.4 2008/03/10 18:35:54 drochner Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.curl
PKG_SUPPORTED_OPTIONS=	inet6 libssh2 gssapi
.include "../../mk/bsd.prefs.mk"
.if ${OPSYS} == NetBSD
# Kerberos is built in - no additional dependency
PKG_SUGGESTED_OPTIONS+=	gssapi
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Minet6)
CONFIGURE_ARGS+=	--enable-ipv6
.else
CONFIGURE_ARGS+=	--disable-ipv6
.endif

.if !empty(PKG_OPTIONS:Mlibssh2)
CONFIGURE_ARGS+= 	--with-libssh2=${BUILDLINK_PREFIX.libssh2:Q}
.  include "../../security/libssh2/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--without-libssh2
.endif

.if !empty(PKG_OPTIONS:Mgssapi)
.include "../../mk/krb5.buildlink3.mk"
CONFIGURE_ARGS+=	--with-gssapi=${KRB5BASE}
CONFIGURE_ARGS+=	--with-gssapi-includes=${KRB5BASE}/include/gssapi
.else
CONFIGURE_ARGS+=	--without-gssapi
.endif
