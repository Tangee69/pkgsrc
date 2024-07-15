# $NetBSD: shell-custom.mk,v 1.1 2024/07/15 09:10:26 jperkin Exp $
#
# Tests for using a custom shell for running the commands.

.SHELL: name="sh" path="echo"
# TODO: demonstrate the other shell features as well:
# - error control
# - output control

all:
	: normal
	@: hidden
	+: always
	-: ignore errors
