# $NetBSD: buildlink3.mk,v 1.1 2023/08/16 05:43:10 markd Exp $

BUILDLINK_TREE+=	akonadi-import-wizard

.if !defined(AKONADI_IMPORT_WIZARD_BUILDLINK3_MK)
AKONADI_IMPORT_WIZARD_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.akonadi-import-wizard+=	akonadi-import-wizard>=20.04.1
BUILDLINK_PKGSRCDIR.akonadi-import-wizard?=	../../mail/akonadi-import-wizard

.include "../../mail/mailcommon/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# AKONADI_IMPORT_WIZARD_BUILDLINK3_MK

BUILDLINK_TREE+=	-akonadi-import-wizard
