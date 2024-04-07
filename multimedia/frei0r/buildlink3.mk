# $NetBSD: buildlink3.mk,v 1.6 2024/04/07 07:34:42 wiz Exp $

BUILDLINK_TREE+=	frei0r

.if !defined(FREI0R_BUILDLINK3_MK)
FREI0R_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.frei0r+=	frei0r>=1.6.1
BUILDLINK_ABI_DEPENDS.frei0r?=	frei0r>=1.8.0nb4
BUILDLINK_PKGSRCDIR.frei0r?=	../../multimedia/frei0r

.include "../../graphics/cairo/buildlink3.mk"
.endif	# FREI0R_BUILDLINK3_MK

BUILDLINK_TREE+=	-frei0r
