# $NetBSD: buildlink3.mk,v 1.10 2024/04/15 09:29:24 adam Exp $

BUILDLINK_TREE+=	gtkmm4

.if !defined(GTKMM4_BUILDLINK3_MK)
GTKMM4_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.gtkmm4+=	gtkmm4>=4.2.0
BUILDLINK_ABI_DEPENDS.gtkmm4+=	gtkmm4>=4.12.0nb1
BUILDLINK_PKGSRCDIR.gtkmm4?=	../../x11/gtkmm4

.include "../../x11/gtk4/buildlink3.mk"
.include "../../devel/glibmm2.68/buildlink3.mk"
.include "../../devel/pangomm2.48/buildlink3.mk"
.include "../../graphics/cairomm1.16/buildlink3.mk"
.include "../../graphics/gdk-pixbuf2/buildlink3.mk"
.endif	# GTKMM4_BUILDLINK3_MK

BUILDLINK_TREE+=	-gtkmm4
