# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Yet Another Cleaner - unsupported portage file cleaner."
HOMEPAGE="http://gentoo.org.mx/yacleaner/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND="sys-apps/portage"

MY_P=${P/_alpha1/alpha}

SRC_URI="http://gentoo.org.mx/yacleaner/${MY_P} http://lepetitfou.dyndns.org/download/distfiles/${MY_P}"

src_unpack() { :; }

src_compile() { :; }

src_install() {
	newbin ${DISTDIR}/${MY_P} ${PN} || die "failed to copy ${P}"
}
