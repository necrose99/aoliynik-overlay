# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perforce-cli/perforce-cli-2006.1.ebuild,v 1.4 2004/07/02 05:11:02 eradicator Exp $

EAPI=2
DESCRIPTION="CLI Tools for a commercial version control system"
HOMEPAGE="http://www.perforce.com/"
SRC_URI="http://www.perforce.com/downloads/perforce/r09.2/bin.linux26x86/p4 -> p4-${PVR}"

LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"

DEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/p4-${PVR} p4
}

src_install() {
	dobin p4 || die
}
