# $NetBSD: buildlink3.mk,v 1.1 2023/01/29 08:39:22 pho Exp $

BUILDLINK_TREE+=	hs-hslua-cli

.if !defined(HS_HSLUA_CLI_BUILDLINK3_MK)
HS_HSLUA_CLI_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-hslua-cli+=	hs-hslua-cli>=1.2.0
BUILDLINK_ABI_DEPENDS.hs-hslua-cli+=	hs-hslua-cli>=1.2.0
BUILDLINK_PKGSRCDIR.hs-hslua-cli?=	../../lang/hs-hslua-cli

.include "../../lang/hs-hslua-core/buildlink3.mk"
.include "../../lang/hs-hslua-marshalling/buildlink3.mk"
.include "../../lang/hs-lua/buildlink3.mk"
.endif	# HS_HSLUA_CLI_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-hslua-cli
