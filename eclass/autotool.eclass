# $Id: autotool.eclass 160 2005-04-02 14:15:04Z sn4ip3r $
# Distributed under the terms of the GNU General Public License v2

ECLASS=autotool
INHERITED="$INHERITED $ECLASS"
DESCRIPTION="eclass to use the right automake/conf/header"


# Usage: want-<tool> <version>
# Example: want-autoconf 2.5

# Or, declare everyone:
# want-autotools <autoconfver> <automakever> <autoheaderver>
# If you want to declare only 2, replace the ignored one with x:
# want-autotools 2.5 x 1.7

want-autoconf() {
	export WANT_AUTOCONF=${1}
	export REQUIRED_AUTOCONF_VERSION=${1}
}

want-automake() {
	export WANT_AUTOMAKE=${1}
	export REQUIRED_AUTOMAKE_VERSION=${1}
}

want-autoheader() {
	export WANT_AUTOHEADER=${1}
}

want-autotools() {
	if [ "$1" -a ! "$1" = "x" ]; then
		want-autoconf ${1}
	fi

	if [ "$2" -a ! "$2" = "x" ]; then
		want-automake ${2}
	fi

	if [ "$3" -a ! "$3" = "x" ]; then
		want-autoheader ${3}
	fi
}

autotool_eautogen() {
	AUTOGEN=${AUTOGEN:-./autogen.sh}
	#confcache_start
	local script
	if [ -x ${AUTOGEN} ]; then
		script="${AUTOGEN}"
	elif [ -x ./configure ]; then
		einfo "No \"${AUTOGEN}\" found, using \"configure\""
		script="./configure"
	else
		die "no ${AUTOGEN} or ./configure script found"
	fi
	
	if [ -n "${CBUILD}" ]; then
		EXTRA_ECONF="--build=${CBUILD} ${EXTRA_ECONF}"
	fi

	if [ "${INCLUDE_CONFIGURE}" = "yes" ]; then
		if [ "${script}" = "${AUTOGEN}" ]; then
			${AUTOGEN} || die "${AUTOGEN} failed"
		fi
		if [ -x ./configure ]; then
			script="./configure"
		else
			ewarn "INCLUDE_CONFIGURE is set, but no runnable"
			ewarn "configure script was found."
			sleep 5
		fi
	fi
	${script} \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--cache-file=$CONF_CACHE \
		${EXTRA_ECONF} \
		"$@" || die "${script} failed"
	#confcache_stop
}

EXPORT_FUNCTIONS eautogen
