# $NetBSD: buildlink3.mk,v 1.4 2023/04/19 08:08:23 adam Exp $

BUILDLINK_TREE+=	ksanecore

.if !defined(KSANECORE_BUILDLINK3_MK)
KSANECORE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ksanecore+=	ksanecore>=22.08.0
BUILDLINK_ABI_DEPENDS.ksanecore?=	ksanecore>=22.08.1nb5
BUILDLINK_PKGSRCDIR.ksanecore?=	../../graphics/ksanecore

.include "../../devel/ki18n/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# KSANECORE_BUILDLINK3_MK

BUILDLINK_TREE+=	-ksanecore
