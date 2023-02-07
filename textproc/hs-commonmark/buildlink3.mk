# $NetBSD: buildlink3.mk,v 1.8 2023/02/07 01:41:09 pho Exp $

BUILDLINK_TREE+=	hs-commonmark

.if !defined(HS_COMMONMARK_BUILDLINK3_MK)
HS_COMMONMARK_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-commonmark+=	hs-commonmark>=0.2.2
BUILDLINK_ABI_DEPENDS.hs-commonmark+=	hs-commonmark>=0.2.2nb1
BUILDLINK_PKGSRCDIR.hs-commonmark?=	../../textproc/hs-commonmark

.include "../../textproc/hs-unicode-data/buildlink3.mk"
.include "../../textproc/hs-unicode-transforms/buildlink3.mk"
.endif	# HS_COMMONMARK_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-commonmark
