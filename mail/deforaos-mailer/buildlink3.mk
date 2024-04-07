# $NetBSD: buildlink3.mk,v 1.20 2024/04/07 07:34:33 wiz Exp $

BUILDLINK_TREE+=	deforaos-mailer

.if !defined(DEFORAOS_MAILER_BUILDLINK3_MK)
DEFORAOS_MAILER_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.deforaos-mailer+=	deforaos-mailer>=0.1.6
BUILDLINK_ABI_DEPENDS.deforaos-mailer?=	deforaos-mailer>=0.2.0nb17
BUILDLINK_PKGSRCDIR.deforaos-mailer?=	../../mail/deforaos-mailer

.include "../../x11/deforaos-libdesktop/buildlink3.mk"
.endif	# DEFORAOS_MAILER_BUILDLINK3_MK

BUILDLINK_TREE+=	-deforaos-mailer
