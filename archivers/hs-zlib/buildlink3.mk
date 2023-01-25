# $NetBSD: buildlink3.mk,v 1.9 2023/01/25 09:48:10 pho Exp $

BUILDLINK_TREE+=	hs-zlib

.if !defined(HS_ZLIB_BUILDLINK3_MK)
HS_ZLIB_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-zlib+=	hs-zlib>=0.6.3
BUILDLINK_ABI_DEPENDS.hs-zlib+=	hs-zlib>=0.6.3.0
BUILDLINK_PKGSRCDIR.hs-zlib?=	../../archivers/hs-zlib

.include "../../devel/zlib/buildlink3.mk"
.endif	# HS_ZLIB_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-zlib
