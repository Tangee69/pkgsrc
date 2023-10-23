$NetBSD: patch-hadrian_src_Settings_Packages.hs,v 1.1 2023/10/23 08:06:49 pho Exp $

Hunk #0, #1:
  Don't assume we always build the threaded RTS. TODO: Upstream this.

Hunk #2:
  Hadrian does something unholy on i386 to gain speed but it seems to be
  incompatible with LLD. Disable the speed hack to work around a linkage
  failure. Ideally we should do this by detecting the type of linker but
  not the OS.

--- hadrian/src/Settings/Packages.hs.orig	2023-09-21 11:30:31.000000000 +0000
+++ hadrian/src/Settings/Packages.hs
@@ -33,6 +33,7 @@ packageArgs = do
       -- NB: in this function, "stage" is the stage of the compiler we are
       -- using to build, but ghcDebugAssertions wants the stage of the compiler
       -- we are building, which we get using succStage.
+    rtsWays          <- getRtsWays
 
     mconcat
         --------------------------------- base ---------------------------------
@@ -163,7 +164,17 @@ packageArgs = do
 
         -------------------------------- haddock -------------------------------
         , package haddock ?
-          builder (Cabal Flags) ? arg "in-ghc-tree"
+          builder (Cabal Flags) ? mconcat
+          [ arg "in-ghc-tree"
+          , ifM stage0
+                -- We build a threaded haddock on stage 1 if the
+                -- bootstrapping compiler supports it.
+                (threadedBootstrapper `cabalFlag` "threaded")
+
+                -- We build a threaded haddock on stage N, N>1 if the
+                -- configuration calls for it.
+                (any (wayUnit Threaded) rtsWays `cabalFlag` "threaded")
+          ]
 
         ---------------------------------- text --------------------------------
         , package text ? mconcat
@@ -440,7 +451,7 @@ rtsPackageArgs = package rts ? do
 speedHack :: Action Bool
 speedHack = do
     i386   <- anyTargetArch ["i386"]
-    goodOS <- not <$> anyTargetOs ["darwin", "solaris2"]
+    goodOS <- not <$> anyTargetOs ["darwin", "solaris2", "freebsd"]
     return $ i386 && goodOS
 
 -- See @rts/ghc.mk@.
