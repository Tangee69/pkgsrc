# $NetBSD: buildlink3.mk,v 1.60 2024/04/07 07:35:25 wiz Exp $

BUILDLINK_TREE+=	ocaml-lablgtk

.if !defined(OCAML_LABLGTK_BUILDLINK3_MK)
OCAML_LABLGTK_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ocaml-lablgtk+=	ocaml-lablgtk>=2.6.0nb3
BUILDLINK_ABI_DEPENDS.ocaml-lablgtk+=	ocaml-lablgtk>=2.18.13nb10
BUILDLINK_PKGSRCDIR.ocaml-lablgtk?=	../../x11/ocaml-lablgtk

# options must be exposed if and only if we built with them
pkgbase := ocaml-lablgtk
.include "../../mk/pkg-build-options.mk"

.if ${PKG_BUILD_OPTIONS.ocaml-lablgtk:Mgtksourceview2}
.  include "../../x11/gtksourceview2/buildlink3.mk"
.endif

.include "../../x11/gtk2/buildlink3.mk"
.endif # OCAML_LABLGTK_BUILDLINK3_MK

BUILDLINK_TREE+=	-ocaml-lablgtk
