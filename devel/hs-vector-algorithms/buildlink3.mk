# $NetBSD: buildlink3.mk,v 1.15 2023/02/07 01:40:54 pho Exp $

BUILDLINK_TREE+=	hs-vector-algorithms

.if !defined(HS_VECTOR_ALGORITHMS_BUILDLINK3_MK)
HS_VECTOR_ALGORITHMS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-vector-algorithms+=	hs-vector-algorithms>=0.8.0
BUILDLINK_ABI_DEPENDS.hs-vector-algorithms+=	hs-vector-algorithms>=0.9.0.1nb1
BUILDLINK_PKGSRCDIR.hs-vector-algorithms?=	../../devel/hs-vector-algorithms

.include "../../devel/hs-bitvec/buildlink3.mk"
.include "../../devel/hs-primitive/buildlink3.mk"
.include "../../devel/hs-vector/buildlink3.mk"
.endif	# HS_VECTOR_ALGORITHMS_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-vector-algorithms
