# $NetBSD: options.mk,v 1.8 2024/08/21 11:31:04 markd Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.akonadi

PKG_OPTIONS_REQUIRED_GROUPS=	db
PKG_OPTIONS_GROUP.db=		mysql sqlite

PKG_SUGGESTED_OPTIONS=		sqlite

.include "../../mk/bsd.options.mk"

###
### Use sqlite backend
###
PLIST_VARS+=	sqlite
.if !empty(PKG_OPTIONS:Msqlite)
.  include "../../databases/sqlite3/buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=	-DAKONADI_BUILD_QSQLITE:BOOL=ON
CMAKE_CONFIGURE_ARGS+=	-DDATABASE_BACKEND=SQLITE
CMAKE_CONFIGURE_ARGS+=	-DSQLITE_INCLUDE_DIR=${BUILDLINK_PREFIX.sqlite3}/include
CMAKE_CONFIGURE_ARGS+=	-DSQLITE_LIBRARIES=${BUILDLINK_PREFIX.sqlite3}/lib/libsqlite3.so
PLIST.sqlite=	yes
.endif
