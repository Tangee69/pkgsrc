# $NetBSD: wheel.mk,v 1.15 2024/11/14 15:08:25 gdt Exp $
#
# Build and install Python wheels
#
# PEP-518 defines how packages specify their build system
# requirements, via the build section in pyproject.toml.  The default
# in the PEP (used when the build section is not present) is
# setuptools and wheel, but setuptools as of 70.1 has enough wheel
# functionality that wheel is not required.  Some packages use
# different build systems, e.g. flit.
#
# wheel.mk does not look for and parse pyproject.toml, and does not
# support variables to declare the needed tools.  Therefore, packages
# including wheel.mk must TOOL_DEPENDS on the needed build tools.
# A typical package will need:
#   TOOL_DEPENDS+=  ${PYPKGPREFIX}-setuptools>=70.1:../../devel/py-setuptools

# Variables:
#
# WHEELFILE:		path to the wheelfile to be installed
#			only needs to be set if do-build is redefined
#
# USE_PYTEST:		If set to yes, depend on py-test and use it for testing.
#			Default: yes
#
# WHEEL_ARGS:		additional arguments to pass during build of the wheel

PY_PATCHPLIST?=	yes
PYSETUPSUBDIR?=	# empty

WHEELFILE?=	${WRKSRC}/${PYSETUPSUBDIR}/dist/*.whl
WHEEL_NAME?=	${DISTNAME:C/-([^0-9])/_\1/g}
_WHEEL_INFODIR=	${WHEEL_NAME}.dist-info
PLIST_SUBST+=	WHEEL_INFODIR=${_WHEEL_INFODIR}
WHEEL_ARGS?=	# empty

PRINT_PLIST_AWK+=	{ gsub(/${_WHEEL_INFODIR:S,.,\.,g}/, "$${WHEEL_INFODIR}") }

.if !target(do-build)
TOOL_DEPENDS+= ${PYPKGPREFIX}-build>=0:../../devel/py-build
do-build:
	${RUN} cd ${WRKSRC}/${PYSETUPSUBDIR} && \
	${SETENV} ${MAKE_ENV} ${TOOL_PYTHONBIN} \
		-m build --wheel --skip-dependency-check --no-isolation ${WHEEL_ARGS}
.endif

.if !target(do-install)
TOOL_DEPENDS+= ${PYPKGPREFIX}-installer>=0.7.0nb1:../../misc/py-installer
do-install:
	${RUN} cd ${WRKSRC}/${PYSETUPSUBDIR} && \
	${SETENV} ${INSTALL_ENV} ${TOOL_PYTHONBIN} \
		-m installer --destdir ${DESTDIR:Q} --prefix ${PREFIX:Q} ${WHEELFILE}
.endif

USE_PYTEST?=	yes
.if !target(do-test) && ${USE_PYTEST:Myes}
TEST_DEPENDS+= ${PYPKGPREFIX}-test-[0-9]*:../../devel/py-test
do-test:
	${RUN} cd ${WRKSRC}/${PYSETUPSUBDIR} && \
	${SETENV} ${TEST_ENV} pytest-${PYVERSSUFFIX}
.endif

.include "../../lang/python/extension.mk"
