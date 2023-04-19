# $NetBSD: buildlink3.mk,v 1.20 2023/04/19 08:08:50 adam Exp $

BUILDLINK_TREE+=	nghttp2

.if !defined(NGHTTP2_BUILDLINK3_MK)
NGHTTP2_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.nghttp2+=	nghttp2>=1.0.0
BUILDLINK_ABI_DEPENDS.nghttp2+=	nghttp2>=1.52.0nb1
BUILDLINK_PKGSRCDIR.nghttp2?=	../../www/nghttp2

.include "../../textproc/libxml2/buildlink3.mk"

.endif # NGHTTP2_BUILDLINK3_MK

BUILDLINK_TREE+=	-nghttp2
