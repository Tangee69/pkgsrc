# $NetBSD: buildlink3.mk,v 1.9 2024/04/29 03:57:17 pho Exp $

BUILDLINK_TREE+=	hs-tar

.if !defined(HS_TAR_BUILDLINK3_MK)
HS_TAR_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-tar+=	hs-tar>=0.6.2
BUILDLINK_ABI_DEPENDS.hs-tar+=	hs-tar>=0.6.2.0
BUILDLINK_PKGSRCDIR.hs-tar?=	../../archivers/hs-tar

.include "../../devel/hs-os-string/buildlink3.mk"
.endif	# HS_TAR_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-tar
