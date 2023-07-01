$NetBSD: patch-test_python_test__metadata.py,v 1.1 2023/07/01 22:14:59 wiz Exp $

Fix build with exiv2 0.28.0.
https://gitlab.gnome.org/GNOME/gexiv2/-/commit/06adc8fb70cb8c77c0cd364195d8251811106ef8

--- test/python/test_metadata.py.orig	2023-05-06 08:50:03.000000000 +0000
+++ test/python/test_metadata.py
@@ -323,18 +323,15 @@ class TestMetadata(unittest.TestCase):
             buf = fd.read()
         metadata = GExiv2.Metadata()
         metadata.open_buf(buf)
-        self.assertEqual(len(metadata.get_exif_tags()), 111)
+        self.assertGreaterEqual(len(metadata.get_exif_tags()), 111)
 
     def test_open_path(self):
         metadata = GExiv2.Metadata()
         metadata.open_path(self.get_input_file())
-        self.assertEqual(len(metadata.get_exif_tags()), 111)
+        self.assertGreaterEqual(len(metadata.get_exif_tags()), 111)
 
     def test_get_tag_string(self):
-        self.assertEqual(
-            [(tag, self.metadata.get_tag_string(tag))
-             for tag in self.metadata.get_exif_tags()
-             if len(self.metadata.get_tag_string(tag)) < 100],
+        reference_data = dict(
             [('Exif.Image.DateTime', '2012:11:02 09:04:27'),
              ('Exif.Image.ExifTag', '234'),
              ('Exif.Image.ImageDescription', '          '),
@@ -440,12 +437,20 @@ class TestMetadata(unittest.TestCase):
              ('Exif.Thumbnail.XResolution', '300/1'),
              ('Exif.Thumbnail.YResolution', '300/1'),
              ])
+        
+        data = dict([(tag, self.metadata.get_tag_string(tag))
+             for tag in self.metadata.get_exif_tags()
+             if len(self.metadata.get_tag_string(tag)) < 100])
+        
+        self.assertEqual(data, data | reference_data)
+
 
     def test_get_tag_interpreted_string(self):
-        self.assertEqual(
+        data = dict(
             [(tag, self.metadata.get_tag_interpreted_string(tag))
              for tag in self.metadata.get_exif_tags()
-             if len(self.metadata.get_tag_interpreted_string(tag)) < 100],
+             if len(self.metadata.get_tag_interpreted_string(tag)) < 100]);
+        reference_data = dict(
             [('Exif.Image.DateTime', '2012:11:02 09:04:27'),
              ('Exif.Image.ExifTag', '234'),
              ('Exif.Image.ImageDescription', '          '),
@@ -551,6 +556,7 @@ class TestMetadata(unittest.TestCase):
              ('Exif.Thumbnail.XResolution', '300'),
              ('Exif.Thumbnail.YResolution', '300'),
              ])
+        self.assertEqual(data, data | reference_data)
 
     def test_has_tag(self):
         self.assertTrue(self.metadata.has_tag('Exif.Image.DateTime'))
@@ -564,7 +570,7 @@ class TestMetadata(unittest.TestCase):
         self.assertFalse(self.metadata.has_tag('Exif.Image.DateTime'))
 
     def test_clear(self):
-        self.assertEqual(len(self.metadata.get_exif_tags()), 111)
+        self.assertGreaterEqual(len(self.metadata.get_exif_tags()), 111)
         self.assertTrue(self.metadata.has_tag('Exif.Image.DateTime'))
         self.assertIsNone(self.metadata.clear())
         self.assertFalse(self.metadata.has_tag('Exif.Image.DateTime'))
