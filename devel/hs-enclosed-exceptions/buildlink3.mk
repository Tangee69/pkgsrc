# $NetBSD: buildlink3.mk,v 1.3 2023/10/09 04:54:13 pho Exp $

BUILDLINK_TREE+=	hs-enclosed-exceptions

.if !defined(HS_ENCLOSED_EXCEPTIONS_BUILDLINK3_MK)
HS_ENCLOSED_EXCEPTIONS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-enclosed-exceptions+=	hs-enclosed-exceptions>=1.0.3
BUILDLINK_ABI_DEPENDS.hs-enclosed-exceptions+=	hs-enclosed-exceptions>=1.0.3nb2
BUILDLINK_PKGSRCDIR.hs-enclosed-exceptions?=	../../devel/hs-enclosed-exceptions

.include "../../devel/hs-lifted-base/buildlink3.mk"
.include "../../devel/hs-monad-control/buildlink3.mk"
.include "../../devel/hs-transformers-base/buildlink3.mk"
.endif	# HS_ENCLOSED_EXCEPTIONS_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-enclosed-exceptions
