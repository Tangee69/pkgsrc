# $NetBSD: buildlink3.mk,v 1.1 2023/01/26 10:52:19 pho Exp $

BUILDLINK_TREE+=	hs-memotrie

.if !defined(HS_MEMOTRIE_BUILDLINK3_MK)
HS_MEMOTRIE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-memotrie+=	hs-memotrie>=0.6.10
BUILDLINK_ABI_DEPENDS.hs-memotrie+=	hs-memotrie>=0.6.10
BUILDLINK_PKGSRCDIR.hs-memotrie?=	../../devel/hs-memotrie

.include "../../devel/hs-newtype-generics/buildlink3.mk"
.endif	# HS_MEMOTRIE_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-memotrie
