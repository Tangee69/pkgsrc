# $NetBSD: buildlink3.mk,v 1.11 2024/04/07 07:33:27 wiz Exp $

BUILDLINK_TREE+=	gnome-autoar

.if !defined(GNOME_AUTOAR_BUILDLINK3_MK)
GNOME_AUTOAR_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.gnome-autoar+=	gnome-autoar>=0.2.4
BUILDLINK_ABI_DEPENDS.gnome-autoar+=	gnome-autoar>=0.4.4nb2
BUILDLINK_PKGSRCDIR.gnome-autoar?=	../../archivers/gnome-autoar

.include "../../archivers/libarchive/buildlink3.mk"
.include "../../x11/gtk3/buildlink3.mk"
.endif	# GNOME_AUTOAR_BUILDLINK3_MK

BUILDLINK_TREE+=	-gnome-autoar
