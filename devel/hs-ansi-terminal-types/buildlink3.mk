# $NetBSD: buildlink3.mk,v 1.3 2024/04/28 20:37:47 pho Exp $

BUILDLINK_TREE+=	hs-ansi-terminal-types

.if !defined(HS_ANSI_TERMINAL_TYPES_BUILDLINK3_MK)
HS_ANSI_TERMINAL_TYPES_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-ansi-terminal-types+=	hs-ansi-terminal-types>=1.1
BUILDLINK_ABI_DEPENDS.hs-ansi-terminal-types+=	hs-ansi-terminal-types>=1.1
BUILDLINK_PKGSRCDIR.hs-ansi-terminal-types?=	../../devel/hs-ansi-terminal-types

.include "../../devel/hs-colour/buildlink3.mk"
.endif	# HS_ANSI_TERMINAL_TYPES_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-ansi-terminal-types
