$NetBSD: patch-src_main.cpp,v 1.3 2024/09/20 00:03:15 bacon Exp $

# Portability

--- src/main.cpp.orig	2023-11-01 12:46:19.000000000 +0000
+++ src/main.cpp
@@ -11,6 +11,7 @@
 #include <limits>
 
 #include <cstdio>
+#include <unistd.h>	// rmdir()
 
 #include "common.h"
 #include "ProcessReads.h"
