#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>

CcacheVars() {
	local i
	: ${CCACHE_BASEDIR="${PORTAGE_TMPDIR:-/var/tmp}/portage"}
	: ${CCACHE_SLOPPINESS='file_macro,time_macros,include_file_mtime'}
	: ${CCACHE_COMPRESS=true}
	[ -z "${CC++}" ] || : ${CCACHE_CPP2:=true}
	for i in BASEDIR CC COMPILERCHECK COMPRESS CPP2 \
		DETECT_SHEBANG DIR DISABLE EXTENSION \
		EXTRAFILES HARDLINK HASHDIR LOGFILE NLEVELS \
		NODIRECT NOSTATS PATH PREFIX READONLY \
		RECACHE SLOPPINESS TEMPDIR UMASK UNIFY
	do	eval "BashrcdTrue \"\${CCACHE_${i}}\"" && \
			export "CCACHE_${i}" || unset "CCACHE_${i}"
	done
}

BashrcdPhase all CcacheVars
