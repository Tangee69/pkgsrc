# $NetBSD: buildlink3.mk,v 1.1 2023/01/29 10:09:10 pho Exp $

BUILDLINK_TREE+=	hs-pandoc-lua-engine

.if !defined(HS_PANDOC_LUA_ENGINE_BUILDLINK3_MK)
HS_PANDOC_LUA_ENGINE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-pandoc-lua-engine+=	hs-pandoc-lua-engine>=0.1
BUILDLINK_ABI_DEPENDS.hs-pandoc-lua-engine+=	hs-pandoc-lua-engine>=0.1
BUILDLINK_PKGSRCDIR.hs-pandoc-lua-engine?=	../../converters/hs-pandoc-lua-engine

.include "../../textproc/hs-citeproc/buildlink3.mk"
.include "../../devel/hs-data-default/buildlink3.mk"
.include "../../textproc/hs-doclayout/buildlink3.mk"
.include "../../textproc/hs-doctemplates/buildlink3.mk"
.include "../../lang/hs-hslua/buildlink3.mk"
.include "../../converters/hs-hslua-aeson/buildlink3.mk"
.include "../../lang/hs-hslua-core/buildlink3.mk"
.include "../../textproc/hs-hslua-module-doclayout/buildlink3.mk"
.include "../../sysutils/hs-hslua-module-path/buildlink3.mk"
.include "../../devel/hs-hslua-module-system/buildlink3.mk"
.include "../../textproc/hs-hslua-module-text/buildlink3.mk"
.include "../../devel/hs-hslua-module-version/buildlink3.mk"
.include "../../archivers/hs-hslua-module-zip/buildlink3.mk"
.include "../../devel/hs-lpeg/buildlink3.mk"
.include "../../converters/hs-pandoc-base/buildlink3.mk"
.include "../../devel/hs-pandoc-lua-marshal/buildlink3.mk"
.include "../../textproc/hs-pandoc-types/buildlink3.mk"
.include "../../security/hs-SHA/buildlink3.mk"
.endif	# HS_PANDOC_LUA_ENGINE_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-pandoc-lua-engine
