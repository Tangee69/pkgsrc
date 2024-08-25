# $NetBSD: options.mk,v 1.3 2024/08/25 06:18:40 wiz Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.flycast

PKG_SUPPORTED_OPTIONS+=		alsa pulseaudio
PKG_SUGGESTED_OPTIONS.Linux+=	alsa

.include "../../mk/bsd.fast.prefs.mk"

.if ${MACHINE_ARCH:M*arm*}
PKG_SUPPORTED_OPTIONS+=		rpi
.endif
.if ${MACHINE_PLATFORM:MNetBSD-*-earmv6hf}
PKG_SUGGESTED_OPTIONS+=		rpi
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Malsa)
.  include "../../audio/alsa-lib/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=		-DCMAKE_DISABLE_FIND_PACKAGE_ALSA=ON
.endif

.if !empty(PKG_OPTIONS:Mpulseaudio)
.  include "../../audio/pulseaudio/buildlink3.mk"
.endif

.if !empty(PKG_OPTIONS:Mrpi)
CMAKE_CONFIGURE_ARGS+=	-DUSE_VIDEOCORE=ON
CMAKE_CONFIGURE_ARGS+=	-DUSE_GLES2=ON
CMAKE_CONFIGURE_ARGS+=	-DUSE_OPENGL=OFF
.  include "../../misc/raspberrypi-userland/buildlink3.mk"
.else
.  if ${OPSYS} != "Darwin"
.    include "../../graphics/MesaLib/buildlink3.mk"
.  endif
.endif
