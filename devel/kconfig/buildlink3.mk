# $NetBSD: buildlink3.mk,v 1.27 2023/04/19 08:08:13 adam Exp $

BUILDLINK_TREE+=	kconfig

.if !defined(KCONFIG_BUILDLINK3_MK)
KCONFIG_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.kconfig+=	kconfig>=5.18.0
BUILDLINK_ABI_DEPENDS.kconfig?=	kconfig>=5.98.0nb4
BUILDLINK_PKGSRCDIR.kconfig?=	../../devel/kconfig

BUILDLINK_FILES.kconfig+=	libexec/kf5/*

.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# KCONFIG_BUILDLINK3_MK

BUILDLINK_TREE+=	-kconfig
