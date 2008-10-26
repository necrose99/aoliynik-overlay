# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Compressing proxy"
HOMEPAGE="http://toonel.net"
SRC_URI="http://www.toonel.net/generic/005050/${PN}.jar"

KEYWORDS="x86"
LICENSE="Commercial"
SLOT="0"

DEPEND="${DEPEND}"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
    echo "Unpacked"
}

src_compile() {
    echo "Compiled"
}

src_install() {
	#dobin xwinwrap
    	insinto /usr/share/${PN}
    	doins ${DISTDIR}/${PN}.jar
	newinitd "${FILESDIR}/${PN}" toonel
}
