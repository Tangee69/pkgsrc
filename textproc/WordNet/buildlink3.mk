# $NetBSD: buildlink3.mk,v 1.4 2023/01/29 21:15:00 ryoon Exp $

BUILDLINK_TREE+=	WordNet

.if !defined(WORDNET_BUILDLINK3_MK)
WORDNET_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.WordNet+=	WordNet>=3.0nb7
BUILDLINK_ABI_DEPENDS.WordNet?=	WordNet>=3.0nb10
BUILDLINK_PKGSRCDIR.WordNet?=	../../textproc/WordNet

.include "../../x11/tk/buildlink3.mk"
.endif	# WORDNET_BUILDLINK3_MK

BUILDLINK_TREE+=	-WordNet
