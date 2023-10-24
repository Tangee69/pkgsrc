# $NetBSD: buildlink3.mk,v 1.2 2023/10/24 22:09:35 wiz Exp $

BUILDLINK_TREE+=	qt6-qtvirtualkeyboard

.if !defined(QT6_QTVIRTUALKEYBOARD_BUILDLINK3_MK)
QT6_QTVIRTUALKEYBOARD_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.qt6-qtvirtualkeyboard+=	qt6-qtvirtualkeyboard>=6.5.2
BUILDLINK_ABI_DEPENDS.qt6-qtvirtualkeyboard+=	qt6-qtvirtualkeyboard>=6.5.3nb1
BUILDLINK_PKGSRCDIR.qt6-qtvirtualkeyboard?=	../../inputmethod/qt6-qtvirtualkeyboard

.include "../../graphics/qt6-qtsvg/buildlink3.mk"
.include "../../lang/qt6-qtdeclarative/buildlink3.mk"
.include "../../x11/qt6-qtbase/buildlink3.mk"
.endif	# QT6_QTVIRTUALKEYBOARD_BUILDLINK3_MK

BUILDLINK_TREE+=	-qt6-qtvirtualkeyboard
