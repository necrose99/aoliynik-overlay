# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils linux-info

DESCRIPTION="QoS script bringing better surfing experience"
HOMEPAGE="http://lartc.org/wondershaper"
LICENSE="GPL-2"
SRC_URI="http://lartc.org/wondershaper/${P}.tar.gz"

IUSE="+cbq htb"
KEYWORDS="~amd64 ~x86"
SLOT="0"
DEPEND=""
RDEPEND="sys-apps/iproute2"

src_prepare() {
	epatch "${FILESDIR}/${PV}-add-mask.patch"
	epatch "${FILESDIR}/${PV}-exit-on-tc-error.patch"
}

src_compile() {
	local script

	cp "${FILESDIR}"/wshaper.confd wshaper.confd

	# CBQ is chosen by default, even if none USE flag is selected.
	if ! use cbq && use htb; then
		echo '#   HTB' >> wshaper.confd
		echo 'ALGORITHM="HTB"' >> wshaper.confd
	else
		echo '#   CBQ' >> wshaper.confd
		use htb && echo '#   HTB' >> wshaper.confd
		echo 'ALGORITHM="CBQ"' >> wshaper.confd
	fi

	# wshaper script is CBQ-based.
	mv wshaper wshaper.cbq

	for script in wshaper.cbq wshaper.htb; do
		awk -f "${FILESDIR}"/strip-config-from-exec.awk "${script}" \
			>"${script}.tmp"
		mv "${script}.tmp" "${script}"
	done
}

src_install() {
	exeinto /usr/libexec/wshaper
	use cbq && doexe wshaper.cbq
	use htb && doexe wshaper.htb
	if ! use cbq && ! use htb; then
		ewarn "No algorithm was chosen, enabling CBQ."
		doexe wshaper.cbq
	fi

	newinitd "${FILESDIR}"/wshaper.initd wshaper
	newconfd wshaper.confd wshaper
	dodoc ChangeLog README TODO VERSION
}

pkg_postinst() {
	if linux-info_get_any_version && linux_config_src_exists; then
		echo
		ewarn "If the following test report contains a missing kernel"
		ewarn "configuration option, you should reconfigure and rebuild your"
		ewarn "kernel before running wshaper.  All options are placed in:"
		ewarn "  -> Networking support"
		ewarn "    -> Networking options"
		ewarn "      -> QoS and/or fair queueing"
		echo

		local CONFIG_CHECK="~NET_ACT_POLICE ~NET_SCH_INGRESS ~NET_CLS_U32"
		use cbq || ! use cbq && ! use htb && CONFIG_CHECK+=" ~NET_SCH_CBQ"
		use htb && CONFIG_CHECK+=" ~NET_SCH_HTB"

		# Kernel configuration options descriptions:
		local desc_net_sch_cbq="Class Based Queueing (CBQ)"
		local desc_net_sch_htb="Hierarchical Token Bucket (HTB)"
		local desc_net_act_police="Actions -> Traffic Policing"
		local desc_net_sch_ingress="Ingress Qdisc"
		local desc_net_cls_u32="Universal 32bit comparisons w/ hashing (U32)"

		local opt desc

		# Generate ERROR_* variables for check_extra_config.
		for opt in ${CONFIG_CHECK}; do
			opt=${opt#\~}
			desc=desc_${opt,,}
			eval "local ERROR_${opt}='CONFIG_${opt}: \"${!desc}\" is missing'"
		done

		check_extra_config
	fi

	echo
	elog "You have to adjust parameters in /etc/conf.d/wshaper.  Please read"
	elog "the README file before doing it."
	echo
}
