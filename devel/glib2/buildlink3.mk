# $NetBSD: buildlink3.mk,v 1.16 2008/05/29 08:03:58 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GLIB2_BUILDLINK3_MK:=	${GLIB2_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	glib2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nglib2}
BUILDLINK_PACKAGES+=	glib2
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}glib2

.if !empty(GLIB2_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.glib2+=	glib2>=2.4.0
BUILDLINK_ABI_DEPENDS.glib2+=	glib2>=2.14.3
BUILDLINK_PKGSRCDIR.glib2?=	../../devel/glib2

PRINT_PLIST_AWK+=	/^@dirrm lib\/gio$$/ { next; }
PRINT_PLIST_AWK+=	/^@dirrm lib\/gio\/modules$$/ \
				{ print "@comment in glib2: " $$0; next; }
.endif	# GLIB2_BUILDLINK3_MK

.include "../../converters/libiconv/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/pcre/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
