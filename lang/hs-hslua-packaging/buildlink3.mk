# $NetBSD: buildlink3.mk,v 1.9 2024/05/02 06:41:01 pho Exp $

BUILDLINK_TREE+=	hs-hslua-packaging

.if !defined(HS_HSLUA_PACKAGING_BUILDLINK3_MK)
HS_HSLUA_PACKAGING_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-hslua-packaging+=	hs-hslua-packaging>=2.3.1
BUILDLINK_ABI_DEPENDS.hs-hslua-packaging+=	hs-hslua-packaging>=2.3.1
BUILDLINK_PKGSRCDIR.hs-hslua-packaging?=	../../lang/hs-hslua-packaging

.include "../../lang/hs-hslua-core/buildlink3.mk"
.include "../../lang/hs-hslua-marshalling/buildlink3.mk"
.include "../../lang/hs-hslua-objectorientation/buildlink3.mk"
.include "../../lang/hs-hslua-typing/buildlink3.mk"
.endif	# HS_HSLUA_PACKAGING_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-hslua-packaging
