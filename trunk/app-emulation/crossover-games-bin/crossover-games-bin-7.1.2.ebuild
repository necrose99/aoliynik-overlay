# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="simplified/streamlined version of wine geared towards games"
HOMEPAGE="http://www.codeweavers.com/products/cxgames/"
SRC_URI="http://media.codeweavers.com/pub/crossover/lameduck/install-crossover-games-${PV}.sh"
LICENSE="CROSSOVER"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-libs/glibc
	dev-lang/perl
	x11-libs/libXext
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir /opt/cxgames
	cp -pPR * "${D}"/opt/cxgames/ || die
	cd "${D}"/opt/cxgames
	rm -rf setup.{data,sh}
}

pkg_postinst() {
	cd "${ROOT}"/opt/cxgames
	[[ ! -e etc/cxgames.conf ]] && cp share/crossover/data/cxgames.conf etc/
}
