$NetBSD: patch-pkgs_sqlite3.44.2_generic_tclsqlite3.c,v 1.1 2024/04/09 01:34:15 tnn Exp $

add missing include for uintptr_t

--- pkgs/sqlite3.44.2/generic/tclsqlite3.c.orig	2024-04-09 01:04:35.609524877 +0000
+++ pkgs/sqlite3.44.2/generic/tclsqlite3.c
@@ -73,6 +73,7 @@
 #   endif
 # endif /* SQLITE_PTRSIZE */
 # if defined(HAVE_STDINT_H)
+# include <stdint.h>
     typedef uintptr_t uptr;
 # elif SQLITE_PTRSIZE==4
     typedef unsigned int uptr;
