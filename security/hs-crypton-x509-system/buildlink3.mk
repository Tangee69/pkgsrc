# $NetBSD: buildlink3.mk,v 1.2 2023/11/02 06:37:20 pho Exp $

BUILDLINK_TREE+=	hs-crypton-x509-system

.if !defined(HS_CRYPTON_X509_SYSTEM_BUILDLINK3_MK)
HS_CRYPTON_X509_SYSTEM_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-crypton-x509-system+=	hs-crypton-x509-system>=1.6.7
BUILDLINK_ABI_DEPENDS.hs-crypton-x509-system+=	hs-crypton-x509-system>=1.6.7nb1
BUILDLINK_PKGSRCDIR.hs-crypton-x509-system?=	../../security/hs-crypton-x509-system

.include "../../security/hs-crypton-x509/buildlink3.mk"
.include "../../security/hs-crypton-x509-store/buildlink3.mk"
.include "../../security/hs-pem/buildlink3.mk"
.endif	# HS_CRYPTON_X509_SYSTEM_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-crypton-x509-system
