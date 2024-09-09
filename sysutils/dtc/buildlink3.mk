# $NetBSD: buildlink3.mk,v 1.3 2024/09/09 19:18:13 adam Exp $

BUILDLINK_TREE+=	dtc

.if !defined(DTC_BUILDLINK3_MK)
DTC_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.dtc+=	dtc>=1.7.0
BUILDLINK_ABI_DEPENDS.dtc+=	dtc>=1.7.0nb1
BUILDLINK_PKGSRCDIR.dtc?=	../../sysutils/dtc
.endif	# DTC_BUILDLINK3_MK

BUILDLINK_TREE+=	-dtc
