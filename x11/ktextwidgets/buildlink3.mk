# $NetBSD: buildlink3.mk,v 1.21 2020/08/17 20:17:53 leot Exp $

BUILDLINK_TREE+=	ktextwidgets

.if !defined(KTEXTWIDGETS_BUILDLINK3_MK)
KTEXTWIDGETS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ktextwidgets+=	ktextwidgets>=5.19.0
BUILDLINK_ABI_DEPENDS.ktextwidgets?=	ktextwidgets>=5.70.0nb1
BUILDLINK_PKGSRCDIR.ktextwidgets?=	../../x11/ktextwidgets

.include "../../devel/kservice/buildlink3.mk"
.include "../../graphics/kiconthemes/buildlink3.mk"
.include "../../textproc/kcompletion/buildlink3.mk"
.include "../../textproc/sonnet/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.include "../../x11/qt5-qtspeech/buildlink3.mk"
.endif	# KTEXTWIDGETS_BUILDLINK3_MK

BUILDLINK_TREE+=	-ktextwidgets
