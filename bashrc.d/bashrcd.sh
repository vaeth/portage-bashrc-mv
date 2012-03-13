#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>

BashrcdTrue() {
	case ${1:-0} in
	[nNf]*|[oO][fF]*|0)	return 1;;
	esac
}

BashrcdEcho() {
	if BashrcdTrue ${NOCOLOR}
	then	printf '>>> %s\n' "${@}"
	else	printf '\033[1;34m>\033[1;36m>\033[1;35m>\033[0m %s\n' "${@}"
	fi
}

BashrcdPhase() {
	local c
	eval "c=\${bashrcd_phases_c_${1}}"
	if [ -n "${c}" ]
	then	c=$(( ${c} + 1 ))
	else	c=0
	fi
	eval "bashrcd_phases_c_${1}=\${c}
	bashrcd_phases_${c}_${1}=\${2}"
}

BashrcdMain() {
	local bashrcd
	for bashrcd in "${CONFIG_ROOT%/}/etc/portage/bashrc.d/"*.sh
	do	case ${bashrcd} in
		*'/bashrcd.sh')
			continue;;
		esac
		test -r "${bashrcd}" || continue
		. "${bashrcd}"
		BashrcdTrue ${BASHRCD_DEBUG} && BashrcdEcho "${bashrcd} sourced"
	done
	unset -f BashrcdPhase
BashrcdMain() {
	local bashrcd_phase bashrcd_num bashrcd_max
	[ ${#} -ne 0 ] && EBUILD_PHASE=${1}
	: ${ED:=${D%/}${EPREFIX%/}/}
	BashrcdTrue ${BASHRCD_DEBUG} && BashrcdEcho \
		"${0}: ${*} (${#} args)" \
		"EBUILD_PHASE=${EBUILD_PHASE}" \
		"PORTDIR=${PORTDIR}" \
		"CATEGORY=${CATEGORY}" \
		"P=${P}" \
		"USER=${USER}" \
		"HOME=${HOME}" \
		"PATH=${PATH}" \
		"ROOT=${ROOT}" \
		"CONFIG_ROOT=${CONFIG_ROOT}" \
		"LD_PRELOAD=${LD_PRELOAD}" \
		"EPREFIX=${EPREFIX}" \
		"D=${D}" \
		"ED=${ED}"
	for bashrcd_phase in all "${EBUILD_PHASE}"
	do	eval "bashrcd_max=\${bashrcd_phases_c_${bashrcd_phase}}"
		[ -z "${bashrcd_max}" ] && continue
		bashrcd_num=0
		while {
			eval "eval \"\\\${bashrcd_phases_${bashrcd_num}_${bashrcd_phase}}\""
			[ ${bashrcd_num} -ne ${bashrcd_max} ]
		}
		do	bashrcd_num=$(( ${bashrcd_num} + 1 ))
		done
	done
}
	BashrcdMain "${@}"
}
