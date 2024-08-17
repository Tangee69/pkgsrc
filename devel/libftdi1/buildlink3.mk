# $NetBSD: buildlink3.mk,v 1.6 2024/08/17 09:18:41 wiz Exp $

BUILDLINK_TREE+=	libftdi1

.if !defined(LIBFTDI1_BUILDLINK3_MK)
LIBFTDI1_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libftdi1+=	libftdi1>=1.0
BUILDLINK_ABI_DEPENDS.libftdi1?=	libftdi1>=1.5nb7
BUILDLINK_PKGSRCDIR.libftdi1?=		../../devel/libftdi1

.include "../../devel/libusb1/buildlink3.mk"
.endif	# LIBFTDI1_BUILDLINK3_MK

BUILDLINK_TREE+=	-libftdi1
