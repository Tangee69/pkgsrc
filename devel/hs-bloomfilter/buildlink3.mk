# $NetBSD: buildlink3.mk,v 1.2 2023/11/02 06:36:21 pho Exp $

BUILDLINK_TREE+=	hs-bloomfilter

.if !defined(HS_BLOOMFILTER_BUILDLINK3_MK)
HS_BLOOMFILTER_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-bloomfilter+=	hs-bloomfilter>=2.0.1
BUILDLINK_ABI_DEPENDS.hs-bloomfilter+=	hs-bloomfilter>=2.0.1.2nb1
BUILDLINK_PKGSRCDIR.hs-bloomfilter?=	../../devel/hs-bloomfilter
.endif	# HS_BLOOMFILTER_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-bloomfilter
