$NetBSD: patch-gfx_angle_checkout_src_compiler_translator_InfoSink.h,v 1.1 2024/08/18 15:02:21 leot Exp $

* isinf/isnan in make.h is defined as macro. Use non-macro version
  to fix build.

--- gfx/angle/checkout/src/compiler/translator/InfoSink.h.orig	2021-10-28 18:03:11.000000000 +0000
+++ gfx/angle/checkout/src/compiler/translator/InfoSink.h
@@ -7,7 +7,7 @@
 #ifndef COMPILER_TRANSLATOR_INFOSINK_H_
 #define COMPILER_TRANSLATOR_INFOSINK_H_
 
-#include <math.h>
+#include <cmath>
 #include <stdlib.h>
 #include "GLSLANG/ShaderLang.h"
 #include "compiler/translator/Common.h"
