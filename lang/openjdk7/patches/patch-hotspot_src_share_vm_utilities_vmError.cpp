$NetBSD: patch-hotspot_src_share_vm_utilities_vmError.cpp,v 1.1 2015/03/01 21:44:29 tnn Exp $

Don't include system headers before setting feature test macros.

--- hotspot/src/share/vm/utilities/vmError.cpp.orig	2015-01-26 15:21:49.000000000 +0000
+++ hotspot/src/share/vm/utilities/vmError.cpp
@@ -22,7 +22,6 @@
  *
  */
 
-#include <fcntl.h>
 #include "precompiled.hpp"
 #include "compiler/compileBroker.hpp"
 #include "gc_interface/collectedHeap.hpp"
