# $NetBSD: buildlink3.mk,v 1.3 2023/04/19 08:08:19 adam Exp $

BUILDLINK_TREE+=	qt6-qttools

.if !defined(QT6_QTTOOLS_BUILDLINK3_MK)
QT6_QTTOOLS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.qt6-qttools+=	qt6-qttools>=6.4.1
BUILDLINK_ABI_DEPENDS.qt6-qttools?=	qt6-qttools>=6.5.0nb1
BUILDLINK_PKGSRCDIR.qt6-qttools?=	../../devel/qt6-qttools


.include "../../x11/qt6-qtbase/buildlink3.mk"
.endif	# QT6_QTTOOLS_BUILDLINK3_MK

BUILDLINK_TREE+=	-qt6-qttools
