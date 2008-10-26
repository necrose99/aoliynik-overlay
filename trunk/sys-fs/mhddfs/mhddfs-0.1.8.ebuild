# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The driver combines a several mount points into the single one."
SRC_URI="http://mhddfs.uvw.ru/downloads/${PN}_${PV}.tar.gz"
HOMEPAGE="http://mhddfs.uvw.ru"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

DEPEND=">=sys-fs/fuse-2.2.1"
RDEPEND=${DEPEND}

src_install () {
	dodir /usr/bin
	exeinto /usr/bin
	doexe mhddfs
	dodoc README ChangeLog
}
