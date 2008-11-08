# $NetBSD: buildlink3.mk,v 1.14 2008/11/08 21:13:27 bjs Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
SDL_SOUND_BUILDLINK3_MK:=	${SDL_SOUND_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	SDL_sound
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NSDL_sound}
BUILDLINK_PACKAGES+=	SDL_sound
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}SDL_sound

.if !empty(SDL_SOUND_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.SDL_sound+=	SDL_sound>=1.0.3
BUILDLINK_ABI_DEPENDS.SDL_sound?=	SDL_sound>=1.0.3nb1
BUILDLINK_PKGSRCDIR.SDL_sound?=	../../audio/SDL_sound
.endif	# SDL_SOUND_BUILDLINK3_MK

.include "../../audio/flac/buildlink3.mk"
.include "../../audio/libmikmod/buildlink3.mk"
.include "../../audio/libvorbis/buildlink3.mk"
.include "../../audio/speex/buildlink3.mk"
.include "../../devel/SDL/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
