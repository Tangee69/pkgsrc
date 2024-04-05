# $NetBSD: buildlink3.mk,v 1.17 2024/04/05 14:00:57 wiz Exp $

BUILDLINK_TREE+=	libgadu

.if !defined(LIBGADU_BUILDLINK3_MK)
LIBGADU_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libgadu+=	libgadu>=1.12.2
BUILDLINK_ABI_DEPENDS.libgadu?=	libgadu>=1.12.2nb26
BUILDLINK_PKGSRCDIR.libgadu?=	../../chat/libgadu

.include "../../devel/protobuf-c/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../security/gnutls/buildlink3.mk"
.endif	# LIBGADU_BUILDLINK3_MK

BUILDLINK_TREE+=	-libgadu
