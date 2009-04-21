# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="af ar bg bn bs ca cs cy da de el en_GB en_US es et fi fr gl gu he
hi hr hu id it ja ka km ko lo lt mk mr nb nl pa pl pt pt_BR ro ru si sk sl sr sv
ta th tr uk vi wa xh zh_CN zn_TW zu"
inherit kde4-base

DESCRIPTION="A modified system information page for konq from Suse"
HOMEPAGE="http://www.sysinfo.rogozinski.org"
SRC_URI="http://rogozinski.cal.pl/public/sysinfo/stable/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="4.2"
IUSE=""

RDEPEND="kde-base/kdelibs:${SLOT}
	sys-apps/hwinfo
	>=sys-apps/dbus-1.0
	>=sys-apps/hal-0.5
	x11-misc/shared-mime-info"

#S=${WORKDIR}/${P}

src_prepare() {
	epatch "${FILESDIR}/${P}-cmake-1.patch"

	kde4-base_src_prepare
}
