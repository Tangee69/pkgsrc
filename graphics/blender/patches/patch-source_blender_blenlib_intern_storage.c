$NetBSD: patch-source_blender_blenlib_intern_storage.c,v 1.3 2024/05/03 20:34:37 ryoon Exp $

Use statvfs on Solaris. (From PR 35928)

--- source/blender/blenlib/intern/storage.cc.orig	2023-05-17 23:38:29.000000000 +0000
+++ source/blender/blenlib/intern/storage.cc
@@ -13,7 +13,7 @@
 
 #include <sys/stat.h>
 
-#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) || defined(__HAIKU__)
+#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) || defined(__HAIKU__) || defined(__sun)
 /* Other modern unix OS's should probably use this also. */
 #  include <sys/statvfs.h>
 #  define USE_STATFS_STATVFS
