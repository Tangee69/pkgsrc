# $NetBSD: options.mk,v 1.2 2021/05/10 14:22:56 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.mariadb-client

PKG_SUPPORTED_OPTIONS+=	ssl
PKG_SUGGESTED_OPTIONS+=	ssl

.include "../../mk/bsd.options.mk"

# Enable OpenSSL support
.if !empty(PKG_OPTIONS:Mssl)
.include "../../security/openssl/buildlink3.mk"
CMAKE_ARGS+=	-DWITH_SSL=system
.else
CMAKE_ARGS+=	-DWITH_SSL=no
.endif
