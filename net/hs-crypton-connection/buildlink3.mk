# $NetBSD: buildlink3.mk,v 1.2 2023/11/02 06:37:16 pho Exp $

BUILDLINK_TREE+=	hs-crypton-connection

.if !defined(HS_CRYPTON_CONNECTION_BUILDLINK3_MK)
HS_CRYPTON_CONNECTION_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-crypton-connection+=	hs-crypton-connection>=0.3.1
BUILDLINK_ABI_DEPENDS.hs-crypton-connection+=	hs-crypton-connection>=0.3.1nb1
BUILDLINK_PKGSRCDIR.hs-crypton-connection?=	../../net/hs-crypton-connection

.include "../../devel/hs-basement/buildlink3.mk"
.include "../../security/hs-crypton-x509/buildlink3.mk"
.include "../../security/hs-crypton-x509-store/buildlink3.mk"
.include "../../security/hs-crypton-x509-system/buildlink3.mk"
.include "../../security/hs-crypton-x509-validation/buildlink3.mk"
.include "../../devel/hs-data-default-class/buildlink3.mk"
.include "../../net/hs-network/buildlink3.mk"
.include "../../net/hs-socks/buildlink3.mk"
.include "../../security/hs-tls/buildlink3.mk"
.endif	# HS_CRYPTON_CONNECTION_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-crypton-connection
