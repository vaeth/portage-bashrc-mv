#!/bin/bash
# (C) Martin Väth <martin@mvath.de>

NoMan() {
	[ -n "${NOMANREMOVE}" ] && return
	has noman ${FEATURES} || return 0
	test -d "${ED}"/usr/share/man || return 0
	einfo "removing undesired man files"
	rm -rfv -- "${ED}"/usr/share/man
}

BashrcdPhase preinst NoMan
