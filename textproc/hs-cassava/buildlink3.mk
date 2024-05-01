# $NetBSD: buildlink3.mk,v 1.11 2024/05/01 14:22:35 pho Exp $

BUILDLINK_TREE+=	hs-cassava

.if !defined(HS_CASSAVA_BUILDLINK3_MK)
HS_CASSAVA_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-cassava+=	hs-cassava>=0.5.3
BUILDLINK_ABI_DEPENDS.hs-cassava+=	hs-cassava>=0.5.3.1
BUILDLINK_PKGSRCDIR.hs-cassava?=	../../textproc/hs-cassava

.include "../../textproc/hs-attoparsec/buildlink3.mk"
.include "../../devel/hs-hashable/buildlink3.mk"
.include "../../devel/hs-Only/buildlink3.mk"
.include "../../math/hs-scientific/buildlink3.mk"
.include "../../devel/hs-unordered-containers/buildlink3.mk"
.include "../../devel/hs-vector/buildlink3.mk"
.include "../../textproc/hs-text-short/buildlink3.mk"
.endif	# HS_CASSAVA_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-cassava
