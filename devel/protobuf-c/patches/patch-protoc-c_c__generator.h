$NetBSD: patch-protoc-c_c__generator.h,v 1.3 2024/04/07 20:53:13 adam Exp $

Chase compatibility issues with Google protobuf 26.0
https://github.com/protobuf-c/protobuf-c/pull/711

--- protoc-c/c_generator.h.orig	2024-04-07 20:33:52.951908700 +0000
+++ protoc-c/c_generator.h
@@ -93,6 +93,12 @@ class PROTOC_C_EXPORT CGenerator : publi
                 const std::string& parameter,
                 OutputDirectory* output_directory,
                 std::string* error) const;
+
+#if GOOGLE_PROTOBUF_VERSION >= 5026000
+  uint64_t GetSupportedFeatures() const { return CodeGenerator::FEATURE_SUPPORTS_EDITIONS; }
+  Edition GetMinimumEdition() const { return Edition::EDITION_PROTO2; }
+  Edition GetMaximumEdition() const { return Edition::EDITION_PROTO3; }
+#endif
 };
 
 }  // namespace c
