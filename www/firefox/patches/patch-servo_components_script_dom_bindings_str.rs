$NetBSD: patch-servo_components_script_dom_bindings_str.rs,v 1.2.2.2 2018/03/09 07:17:30 spz Exp $

--- servo/components/script/dom/bindings/str.rs.orig	2017-11-02 16:16:33.000000000 +0000
+++ servo/components/script/dom/bindings/str.rs
@@ -7,7 +7,6 @@
 use cssparser::CowRcStr;
 use html5ever::{LocalName, Namespace};
 use servo_atoms::Atom;
-use std::ascii::AsciiExt;
 use std::borrow::{Borrow, Cow, ToOwned};
 use std::fmt;
 use std::hash::{Hash, Hasher};
