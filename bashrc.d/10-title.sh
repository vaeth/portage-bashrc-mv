#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>

QlopSetup() {
	local num sec hour min date
	command -v qlop >/dev/null 2>&1 || return 0
	qlop -gH -- "$CATEGORY/$PN"
	qlop -tH -- "$CATEGORY/$PN"
	command -v title >/dev/null 2>&1 || return 0
	num=$(tail -n1 /var/log/emerge.log | \
		sed -e 's/^.*(\([0-9]*\) of \([0-9]*\)).*$/\1|\2/') \
	&& [ -n "$num" ] || {
		date=$(date +%T)
		title "emerge $date $PN"
		return
	}
	sec=$(qlop -tC -- "$CATEGORY/$PN" | \
		sed -e 's/^.* \([0-9]*\) second.*$/\1/') \
	&& [ -n "$sec" ] || {
		date=$(date +%T)
		title "emerge $date $num $PN"
		return
	}
	hour=$(( $sec / 3600 ))
	[ "$hour" -gt 0 ] || hour=
	hour=$hour${hour:+:}
	sec=$(( $sec % 3600 ))
	min=$(( $sec / 60 ))
	sec=$(( $sec % 60 ))
	[ "$min" -gt 9 ] || min=0$min
	[ "$sec" -gt 9 ] || sec=0$sec
	date=$(date +%T)
	title "emerge $date $num $PN $hour$min:$sec"
}

BashrcdPhase setup QlopSetup
