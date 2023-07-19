# $NetBSD: buildlink3.mk,v 1.4 2023/07/19 15:04:32 nia Exp $

BUILDLINK_TREE+=	libsigcpp3

.if !defined(LIBSIGCPP3_BUILDLINK3_MK)
LIBSIGCPP3_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libsigcpp3+=	libsigc++3>=3.0.0
BUILDLINK_ABI_DEPENDS.libsigcpp3?=	libsigc++3>=3.0.7nb1
BUILDLINK_PKGSRCDIR.libsigcpp3?=	../../devel/libsigc++3

USE_CXX_FEATURES+=	c++17

.endif # LIBSIGCPP3_BUILDLINK3_MK

BUILDLINK_TREE+=	-libsigcpp3
