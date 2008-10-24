# $NetBSD: buildlink3.mk,v 1.9 2008/10/24 20:31:54 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GTKHTML314_BUILDLINK3_MK:=	${GTKHTML314_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gtkhtml314
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngtkhtml314}
BUILDLINK_PACKAGES+=	gtkhtml314
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gtkhtml314

.if !empty(GTKHTML314_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gtkhtml314+=	gtkhtml314>=3.24.0
BUILDLINK_PKGSRCDIR.gtkhtml314?=	../../www/gtkhtml314
.endif	# GTKHTML314_BUILDLINK3_MK

.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../textproc/enchant/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
