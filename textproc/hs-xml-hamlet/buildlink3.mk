# $NetBSD: buildlink3.mk,v 1.2 2023/11/02 06:37:41 pho Exp $

BUILDLINK_TREE+=	hs-xml-hamlet

.if !defined(HS_XML_HAMLET_BUILDLINK3_MK)
HS_XML_HAMLET_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-xml-hamlet+=	hs-xml-hamlet>=0.5.0
BUILDLINK_ABI_DEPENDS.hs-xml-hamlet+=	hs-xml-hamlet>=0.5.0.2nb1
BUILDLINK_PKGSRCDIR.hs-xml-hamlet?=	../../textproc/hs-xml-hamlet

.include "../../textproc/hs-shakespeare/buildlink3.mk"
.include "../../textproc/hs-xml-conduit/buildlink3.mk"
.endif	# HS_XML_HAMLET_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-xml-hamlet
