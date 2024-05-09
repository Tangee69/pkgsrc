# $NetBSD: buildlink3.mk,v 1.12 2024/05/09 01:31:59 pho Exp $

BUILDLINK_TREE+=	hs-hls-plugin-api

.if !defined(HS_HLS_PLUGIN_API_BUILDLINK3_MK)
HS_HLS_PLUGIN_API_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-hls-plugin-api+=	hs-hls-plugin-api>=2.7.0
BUILDLINK_ABI_DEPENDS.hs-hls-plugin-api+=	hs-hls-plugin-api>=2.7.0.0nb1
BUILDLINK_PKGSRCDIR.hs-hls-plugin-api?=		../../devel/hs-hls-plugin-api

.include "../../converters/hs-aeson/buildlink3.mk"
.include "../../sysutils/hs-co-log-core/buildlink3.mk"
.include "../../devel/hs-data-default/buildlink3.mk"
.include "../../devel/hs-dependent-map/buildlink3.mk"
.include "../../devel/hs-dependent-sum/buildlink3.mk"
.include "../../textproc/hs-Diff/buildlink3.mk"
.include "../../devel/hs-dlist/buildlink3.mk"
.include "../../misc/hs-extra/buildlink3.mk"
.include "../../devel/hs-hashable/buildlink3.mk"
.include "../../devel/hs-hls-graph/buildlink3.mk"
.include "../../devel/hs-lens/buildlink3.mk"
.include "../../converters/hs-lens-aeson/buildlink3.mk"
.include "../../devel/hs-lsp/buildlink3.mk"
.include "../../textproc/hs-megaparsec/buildlink3.mk"
.include "../../sysutils/hs-opentelemetry/buildlink3.mk"
.include "../../devel/hs-optparse-applicative/buildlink3.mk"
.include "../../textproc/hs-prettyprinter/buildlink3.mk"
.include "../../textproc/hs-regex-tdfa/buildlink3.mk"
.include "../../devel/hs-unliftio/buildlink3.mk"
.include "../../devel/hs-unordered-containers/buildlink3.mk"
.include "../../devel/hs-hw-fingertree/buildlink3.mk"
.endif	# HS_HLS_PLUGIN_API_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-hls-plugin-api
