# $NetBSD: options.mk,v 1.4 2008/04/12 22:43:03 jlam Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.dkim-milter
PKG_SUPPORTED_OPTIONS=	inet6 dkim-milter-arlib debug

.include "../../mk/bsd.options.mk"

###
### IPv6 support.
###
.if !empty(PKG_OPTIONS:Minet6)
SUBST_SED.libs+=	-e 's|@INET6@||g'
.else
SUBST_SED.libs+=	-e 's|@INET6@|dnl|g'
.endif

###
### Debug support
###
.if !empty(PKG_OPTIONS:Mdebug)
SUBST_SED.libs+=	-e 's|@DEBUG@||g'
.else
SUBST_SED.libs+=	-e 's|@DEBUG@|dnl|g'
.endif

###
### Use asynchronous DNS resolver library shipping with dkim-milter.
###
PLIST_VARS+=		arlib
.if !empty(PKG_OPTIONS:Mdkim-milter-arlib)
PLIST.arlib=		yes
SUBST_SED.libs+=	-e 's|@RESOLVLIB@||g'
SUBST_SED.libs+=	-e 's|@ARLIB@||g'
.else
SUBST_SED.libs+=	-e 's|@RESOLVLIB@|resolv bind|g'
SUBST_SED.libs+=	-e 's|@ARLIB@|dnl|g'
.endif
