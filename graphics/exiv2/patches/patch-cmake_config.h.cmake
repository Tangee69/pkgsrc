$NetBSD: patch-cmake_config.h.cmake,v 1.3 2023/05/16 20:38:21 wiz Exp $

Support newer NetBSD versions.
https://github.com/Exiv2/exiv2/pull/2626

--- cmake/config.h.cmake.orig	2019-07-29 06:33:06.000000000 +0000
+++ cmake/config.h.cmake
@@ -35,7 +35,17 @@
 
 /* Define to `const' or to empty, depending on the second argument of `iconv'. */
 #cmakedefine ICONV_ACCEPTS_CONST_INPUT
-#if defined(ICONV_ACCEPTS_CONST_INPUT) || defined(__NetBSD__)
+
+#if defined(__NetBSD__)
+#include <sys/param.h>
+#if __NetBSD_Prereq__(9,99,17)
+#define NETBSD_POSIX_ICONV 1
+#else
+#define NETBSD_POSIX_ICONV 0
+#endif
+#endif
+
+#if defined(ICONV_ACCEPTS_CONST_INPUT) || (defined(__NetBSD__) && !NETBSD_POSIX_ICONV)
 #define EXV_ICONV_CONST const
 #else
 #define EXV_ICONV_CONST
