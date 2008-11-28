# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Compiz Fusion (meta)"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome kde unsupported"

RDEPEND="~x11-wm/compiz-${PV}
	~x11-plugins/compiz-fusion-plugins-main-${PV}
	~x11-plugins/compiz-fusion-plugins-extra-${PV}
	unsupported? ( ~x11-plugins/compiz-fusion-plugins-unsupported-${PV} )
	~x11-apps/ccsm-${PV}
	~x11-wm/emerald-${PV}
	gnome? ( ~x11-libs/compizconfig-backend-gconf-${PV} )
	kde? ( ~x11-libs/compizconfig-backend-kconfig-${PV} )"

pkg_postinst() {
	ewarn "If you want to try out simple-ccsm, you'll need to emerge it"
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to #gentoo-desktop-effects"
	einfo "Thank you on behalf of the Gentoo Desktop-Effects team"
}
