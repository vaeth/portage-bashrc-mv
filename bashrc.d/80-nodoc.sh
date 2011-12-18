#!/bin/bash
# (C) Martin Väth <martin@mvath.de>

NoDoc() {
	[ -n "${NODOCREMOVE}" ] && return
	has nodoc ${FEATURES} || return 0
	test -d "${ED}"/usr/share/doc || return 0
	einfo "removing undesired doc files"
	rm -rfv -- "${ED}"/usr/share/doc
}

BashrcdPhase preinst NoDoc
