# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.2"
QT_MINIMAL="4.6.0_beta"

inherit kde4-base subversion

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://websvn.kde.org/trunk/kdereview/networkmanagement/"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdereview/networkmanagement"


LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86"
SLOT="4"
IUSE="consolekit debug +networkmanager wicd"

DEPEND="
	!kde-misc/networkmanager-applet
	kde-base/solid[networkmanager?,wicd?]
	>=net-misc/networkmanager-0.7
	consolekit? ( sys-auth/consolekit )
"
RDEPEND="${DEPEND}"

LDFLAGS=""

pkg_setup() {
	if ! use networkmanager && ! use wicd; then
		eerror "You need to pick up one of the backend implementations"
		eerror "   * networkmanager"
		eerror "   * wicd"
		die "No backend selected"
	fi

	kde4-base_pkg_setup
}

src_configure() {
	if ! use consolekit; then
		# Fix dbus policy
		sed -i \
			-e 's/at_console=".*"/group="plugdev"/' \
			"${S}/NetworkManager-kde4.conf" \
			|| die "Fixing dbus policy failed"
	fi

	mycmakeargs="${mycmakeargs}
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d"

	kde4-base_src_configure
}

