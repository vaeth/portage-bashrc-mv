#!/bin/bash
# (C) Martin Väth <martin@mvath.de>

NoInfo() {
	[ -n "${NOINFOREMOVE}" ] && return
	has noinfo ${FEATURES} || return 0
	test -d "${ED}"/usr/share/info || return 0
	einfo "removing undesired info files"
	rm -rfv -- "${ED}"/usr/share/info
}

BashrcdPhase preinst NoInfo
