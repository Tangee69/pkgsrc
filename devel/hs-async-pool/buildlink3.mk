# $NetBSD: buildlink3.mk,v 1.4 2023/10/09 04:54:07 pho Exp $

BUILDLINK_TREE+=	hs-async-pool

.if !defined(HS_ASYNC_POOL_BUILDLINK3_MK)
HS_ASYNC_POOL_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-async-pool+=	hs-async-pool>=0.9.1
BUILDLINK_ABI_DEPENDS.hs-async-pool+=	hs-async-pool>=0.9.1nb3
BUILDLINK_PKGSRCDIR.hs-async-pool?=	../../devel/hs-async-pool

.include "../../devel/hs-async/buildlink3.mk"
.include "../../devel/hs-fgl/buildlink3.mk"
.include "../../devel/hs-monad-control/buildlink3.mk"
.include "../../devel/hs-transformers-base/buildlink3.mk"
.endif	# HS_ASYNC_POOL_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-async-pool
