# $NetBSD: buildlink3.mk,v 1.1 2023/01/31 18:43:22 pho Exp $

BUILDLINK_TREE+=	hs-apply-refact

.if !defined(HS_APPLY_REFACT_BUILDLINK3_MK)
HS_APPLY_REFACT_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-apply-refact+=	hs-apply-refact>=0.12.0
BUILDLINK_ABI_DEPENDS.hs-apply-refact+=	hs-apply-refact>=0.12.0.0
BUILDLINK_PKGSRCDIR.hs-apply-refact?=	../../devel/hs-apply-refact

.include "../../misc/hs-extra/buildlink3.mk"
.include "../../sysutils/hs-filemanip/buildlink3.mk"
.include "../../devel/hs-ghc-exactprint/buildlink3.mk"
.include "../../devel/hs-refact/buildlink3.mk"
.include "../../devel/hs-syb/buildlink3.mk"
.include "../../devel/hs-uniplate/buildlink3.mk"
.include "../../devel/hs-unix-compat/buildlink3.mk"
.endif	# HS_APPLY_REFACT_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-apply-refact
