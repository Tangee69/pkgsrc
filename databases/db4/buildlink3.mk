# $NetBSD: buildlink3.mk,v 1.34 2008/09/06 20:53:51 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DB4_BUILDLINK3_MK:=	${DB4_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	db4
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndb4}
BUILDLINK_PACKAGES+=	db4
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}db4

.if !empty(DB4_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.db4+=	db4>=4.7.25.1
BUILDLINK_ABI_DEPENDS.db4?=	db4>=4.7.25.1
BUILDLINK_PKGSRCDIR.db4?=	../../databases/db4
BUILDLINK_INCDIRS.db4?=		include/db4
BUILDLINK_LDADD.db4=		-ldb4
BUILDLINK_TRANSFORM+=		l:db-4:db4

.  include "../../mk/bsd.fast.prefs.mk"
.  if defined(USE_DB185) && !empty(USE_DB185:M[yY][eE][sS])
BUILDLINK_LIBS.db4=		${BUILDLINK_LDADD.db4}
BUILDLINK_TRANSFORM+=		l:db:db4
.  endif

.  include "../../mk/compiler.mk"
.  if empty(PKGSRC_COMPILER:Mgcc)
PTHREAD_OPTS+=	native
.    include "../../mk/pthread.buildlink3.mk"
.  endif
.endif	# DB4_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
