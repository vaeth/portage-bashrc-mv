#!/bin/bash
# (C) Martin V\"ath <martin@mvath.de>

LocalePurge() {
	BashrcdTrue $NOLOCALEPURGE && return
	local locale_config locale_list locale_cmd shell
	locale_config=${EROOT%/}/etc/locale.nopurge
	locale_list=${EROOT%/}/var/cache/localepurge/localelist
	test -f "$locale_config" && test -f "$locale_list" || return 0
	grep -xq '^NEEDSCONFIGFIRST' -- "$locale_config" && return
	locale_list=`grep -xvf $locale_config -- "$locale_list"`
	[ -z "${locale_list:++}" ] && return
	einfo "removing undesired locales"
	locale_cmd='for d
do	for l in $locale_list
do	if test -d "$d/$l$k"
then	rm -rvf -- "$d/$l"
fi
done
done'
	export locale_list
	shell=`command -v sh` || shell=
	: ${shell:=/bin/sh}
	find "$ED" -name locale -type d -exec "$shell" -c "k='/LC_MESSAGES'
$locale_cmd" sh '{}' '+'
	if grep -xq '^MANDELETE' -- "$locale_config"
	then	find "$ED" -name man -type d -exec "$shell" -c "k=
$locale_cmd" sh '{}' '+'
	fi
	unset locale_list
}

BashrcdPhase preinst LocalePurge
