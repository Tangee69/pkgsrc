# $NetBSD: buildlink3.mk,v 1.41 2023/08/14 05:24:24 wiz Exp $

BUILDLINK_TREE+=	fontconfig

.if !defined(FONTCONFIG_BUILDLINK3_MK)
FONTCONFIG_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.fontconfig+=	fontconfig>=2.11.91
BUILDLINK_ABI_DEPENDS.fontconfig+=	fontconfig>=2.14.2nb2
BUILDLINK_PKGSRCDIR.fontconfig?=	../../fonts/fontconfig

.include "../../archivers/bzip2/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../textproc/expat/buildlink3.mk"
.endif # FONTCONFIG_BUILDLINK3_MK

BUILDLINK_TREE+=	-fontconfig
