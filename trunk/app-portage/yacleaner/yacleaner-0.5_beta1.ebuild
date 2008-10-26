# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#MY_P=${P/_alpha1/alpha}
MY_P=${P/_beta1/beta}

DESCRIPTION="Yet Another Cleaner - unsupported portage file cleaner."
HOMEPAGE="http://blog.tacvbo.net/data/files/gentoo/yacleaner/"
SRC_URI="http://blog.tacvbo.net/data/files/gentoo/yacleaner/${MY_P} http://lepetitfou.dyndns.org/download/distfiles/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="sys-apps/portage"

src_unpack() { :; }

src_compile() { :; }

src_install() {
	newbin ${DISTDIR}/${MY_P} ${PN} || die "failed to copy ${P}"
}
