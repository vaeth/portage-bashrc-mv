#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>

CcacheVars() {
	local i
	: ${CCACHE_BASEDIR="${PORTAGE_TMPDIR:-/var/tmp}/portage"}
	: ${CCACHE_SLOPPINESS='file_macro,time_macros,include_file_mtime'}
	: ${CCACHE_COMPRESS=true}
	[ -z "${CC++}" ] || : ${CCACHE_CPP2:=true}
	for i in CCACHE_BASEDIR CCACHE_COMPRESS CCACHE_SLOPPINESS CCACHE_CPP2
	do	eval "[ -n \"${i:++}\" ]" && \
			export ${i} || unset ${i}
	done
}

BashrcdPhase setup CcacheVars
