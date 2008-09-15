# $NetBSD: replace.mk,v 1.10 2008/09/15 08:40:55 taca Exp $
#

.if !defined(_RUBY_REPLACE_MK)
_RUBY_REPLACE_MK=	# defined

.include "${.PARSEDIR}/rubyversion.mk"

# fix shebang line.
#
# REPLACE_RUBY		replace shebang line of specified files.
#
.if defined(REPLACE_RUBY)
REPLACE_INTERPRETER+=	${RUBY_NAME}

REPLACE.${RUBY_NAME}.old=	.*ruby[0-9]*
REPLACE.${RUBY_NAME}.new=	${RUBY}
REPLACE_FILES.${RUBY_NAME}=	${REPLACE_RUBY}

.endif # defined(REPLACE_RUBY)

# REPLACE_RUBY_DIRS	replace shebang line of files under specified
#			directories; relative paths are assumed to be
#			under ${WRKSRC}.
# REPLACE_RUBY_PAT	specify pattern to match target files under
#			REPLACE_RUBY_DIRS directories.
#
REPLACE_RUBY_PAT?=	*.rb

.if defined(REPLACE_RUBY_DIRS) && !empty(REPLACE_RUBY_DIRS)
pre-configure: replace-ruby-dirs

.for f in ${REPLACE_RUBY_PAT}
_REPLACE_RUBY_PAT+= -o -name "${f}"
.endfor
_REPLACE_RUBY_FIND_ARGS=\( ${_REPLACE_RUBY_PAT:S/-o//1} \)

replace-ruby-dirs:
	${RUN} cd ${WRKSRC} && \
	    for d in ${REPLACE_RUBY_DIRS}; do \
		test -d $$d && dirs="$$dirs $$d"; \
	    done; \
	    if [ -z "$$dirs" ]; then \
		exit 0; \
	    fi; \
	    ${FIND} $$dirs \
		-type f ${_REPLACE_RUBY_FIND_ARGS} -print | \
	    while read f; do \
		${SED}	-e '1s| *[a-z0-9_/\.-][a-z0-9_/\.-]*/env *||g' \
			-e '1s| *[a-z0-9_/\.-]*ruby|${RUBY}|' $$f > $$f.tmp; \
		if ${CMP} -s $$f $$f.tmp; then \
			${RM} $$f.tmp; \
		else \
			${MV} $$f.tmp $$f; \
		fi; \
	    done
.else
replace-ruby-dirs:
.endif # defined(REPLACE_RUBY_DIRS)
.endif # _RUBY_REPLACE_MK
