# $NetBSD: buildlink3.mk,v 1.33 2024/04/06 08:06:25 wiz Exp $

BUILDLINK_TREE+=	phonon-qt5

.if !defined(PHONON_QT5_BUILDLINK3_MK)
PHONON_QT5_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.phonon-qt5+=	phonon-qt5>=4.8.3
BUILDLINK_ABI_DEPENDS.phonon-qt5?=	phonon-qt5>=4.11.1nb19
BUILDLINK_PKGSRCDIR.phonon-qt5?=	../../multimedia/phonon-qt5

.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# PHONON_QT5_BUILDLINK3_MK

BUILDLINK_TREE+=	-phonon-qt5
