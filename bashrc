#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>
[ "`type -t BashrcdMain`" = function ] || \
. "${PORTAGE_CONFIGROOT%/}/etc/portage/bashrc.d/bashrcd.sh"
BashrcdMain "$@"
