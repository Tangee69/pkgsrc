# $NetBSD: buildlink3.mk,v 1.1 2023/01/29 10:07:37 pho Exp $

BUILDLINK_TREE+=	hs-pandoc-base

.if !defined(HS_PANDOC_BASE_BUILDLINK3_MK)
HS_PANDOC_BASE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-pandoc-base+=	hs-pandoc-base>=3.0.1
BUILDLINK_ABI_DEPENDS.hs-pandoc-base+=	hs-pandoc-base>=3.0.1
BUILDLINK_PKGSRCDIR.hs-pandoc-base?=	../../converters/hs-pandoc-base

# lib:pandoc
.include "../../converters/hs-aeson/buildlink3.mk"
.include "../../converters/hs-aeson-pretty/buildlink3.mk"
.include "../../textproc/hs-attoparsec/buildlink3.mk"
.include "../../converters/hs-base64/buildlink3.mk"
.include "../../textproc/hs-blaze-html/buildlink3.mk"
.include "../../textproc/hs-blaze-markup/buildlink3.mk"
.include "../../textproc/hs-case-insensitive/buildlink3.mk"
.include "../../textproc/hs-citeproc/buildlink3.mk"
.include "../../textproc/hs-commonmark/buildlink3.mk"
.include "../../textproc/hs-commonmark-extensions/buildlink3.mk"
.include "../../textproc/hs-commonmark-pandoc/buildlink3.mk"
.include "../../net/hs-connection/buildlink3.mk"
.include "../../devel/hs-data-default/buildlink3.mk"
.include "../../textproc/hs-doclayout/buildlink3.mk"
.include "../../textproc/hs-doctemplates/buildlink3.mk"
.include "../../converters/hs-emojis/buildlink3.mk"
.include "../../devel/hs-file-embed/buildlink3.mk"
.include "../../textproc/hs-Glob/buildlink3.mk"
.include "../../textproc/hs-gridtables/buildlink3.mk"
.include "../../textproc/hs-haddock-library/buildlink3.mk"
.include "../../www/hs-http-client/buildlink3.mk"
.include "../../www/hs-http-client-tls/buildlink3.mk"
.include "../../www/hs-http-types/buildlink3.mk"
.include "../../devel/hs-ipynb/buildlink3.mk"
.include "../../textproc/hs-jira-wiki-markup/buildlink3.mk"
.include "../../graphics/hs-JuicyPixels/buildlink3.mk"
.include "../../net/hs-mime-types/buildlink3.mk"
.include "../../net/hs-network/buildlink3.mk"
.include "../../net/hs-network-uri/buildlink3.mk"
.include "../../textproc/hs-pandoc-types/buildlink3.mk"
.include "../../devel/hs-pretty-show/buildlink3.mk"
.include "../../devel/hs-random/buildlink3.mk"
.include "../../devel/hs-safe/buildlink3.mk"
.include "../../math/hs-scientific/buildlink3.mk"
.include "../../security/hs-SHA/buildlink3.mk"
.include "../../textproc/hs-skylighting/buildlink3.mk"
.include "../../textproc/hs-skylighting-core/buildlink3.mk"
.include "../../devel/hs-split/buildlink3.mk"
.include "../../devel/hs-syb/buildlink3.mk"
.include "../../textproc/hs-tagsoup/buildlink3.mk"
.include "../../sysutils/hs-temporary/buildlink3.mk"
.include "../../textproc/hs-texmath/buildlink3.mk"
.include "../../converters/hs-text-conversions/buildlink3.mk"
.include "../../textproc/hs-unicode-collation/buildlink3.mk"
.include "../../textproc/hs-unicode-transforms/buildlink3.mk"
.include "../../textproc/hs-xml/buildlink3.mk"
.include "../../textproc/hs-yaml/buildlink3.mk"
.include "../../archivers/hs-zip-archive/buildlink3.mk"
.include "../../archivers/hs-zlib/buildlink3.mk"

# lib:xml-light
.include "../../textproc/hs-xml/buildlink3.mk"
.include "../../textproc/hs-xml-conduit/buildlink3.mk"
.include "../../textproc/hs-xml-types/buildlink3.mk"

.endif	# HS_PANDOC_BASE_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-pandoc-base
