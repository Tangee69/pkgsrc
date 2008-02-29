# $NetBSD: buildlink3.mk,v 1.3 2008/02/29 19:23:07 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
NCURSESW_BUILDLINK3_MK:=${NCURSESW_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	ncursesw
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nncursesw}
BUILDLINK_PACKAGES+=	ncursesw
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}ncursesw

.if !empty(NCURSESW_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.ncursesw+=	ncursesw>=5.5
BUILDLINK_ABI_DEPENDS.ncursesw+=	ncursesw>=5.5
BUILDLINK_PKGSRCDIR.ncursesw?=		../../devel/ncursesw

BUILDLINK_LIBNAME.ncursesw=	ncursesw
BUILDLINK_LDADD.ncursesw=	${BUILDLINK_LIBNAME.ncursesw:S/^/-l/:S/^-l$//}
.endif	# NCURSESW_BUILDLINK3_MK

.include "../../devel/ncurses/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
