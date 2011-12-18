#!/bin/bash
# (C) Martin Väth <martin@mvath.de>
[ "`type -t BashrcdMain`" = function ] || \
. "${CONFIG_ROOT%/}/etc/portage/bashrc.d/bashrcd.sh"
BashrcdMain "${@}"
