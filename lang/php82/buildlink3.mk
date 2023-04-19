# $NetBSD: buildlink3.mk,v 1.3 2023/04/19 08:08:28 adam Exp $

BUILDLINK_TREE+=	php

.if !defined(PHP_BUILDLINK3_MK)
PHP_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.php+=	php>=8.2.0<8.3
BUILDLINK_ABI_DEPENDS.php+=	php>=8.2.5nb1
BUILDLINK_PKGSRCDIR.php?=	../../lang/php82

pkgbase := php
.include "../../mk/pkg-build-options.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.endif # PHP_BUILDLINK3_MK

BUILDLINK_TREE+=	-php
