# $NetBSD: buildlink3.mk,v 1.12 2022/01/18 02:48:24 pho Exp $

BUILDLINK_TREE+=	hs-case-insensitive

.if !defined(HS_CASE_INSENSITIVE_BUILDLINK3_MK)
HS_CASE_INSENSITIVE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-case-insensitive+=	hs-case-insensitive>=1.2.1
BUILDLINK_ABI_DEPENDS.hs-case-insensitive+=	hs-case-insensitive>=1.2.1.0nb2
BUILDLINK_PKGSRCDIR.hs-case-insensitive?=	../../textproc/hs-case-insensitive

.include "../../devel/hs-hashable/buildlink3.mk"
.endif	# HS_CASE_INSENSITIVE_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-case-insensitive
