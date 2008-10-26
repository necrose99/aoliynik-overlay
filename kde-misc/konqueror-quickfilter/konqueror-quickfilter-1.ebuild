# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit eutils

DESCRIPTION="A Konqueror toolbar that filters out files"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=22720"
SRC_URI="http://www.gentooexperimental.org/~sleepyhead/kip/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

IUSE=""
SLOT="0"

RESTRICT="mirror"

DEPEND="|| ( kde-base/konqueror kde-base/kdebase )"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
}

src_compile() { :; }

src_install() {
	local KDE_DIR=$(kde-config --prefix)
	mkdir -p ${S}${KDE_DIR}
	mv ${S}/share ${S}${KDE_DIR}
	cp -dPR usr ${D}
}
