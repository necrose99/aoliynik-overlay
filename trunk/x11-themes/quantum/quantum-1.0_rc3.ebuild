# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base qt4

MY_PN="QuantumStyle"
DESCRIPTION="QuantumStyle is an SVG themable style for Qt 4 and KDE4"
HOMEPAGE="http://www.kde-look.org/content/show.php/QuantumStyle?content=101088"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/101088-${MY_PN}-rc3.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${MY_PN}


src_compile() {
	eqmake4  quantumstyle.pro || die "qmake failed"
	emake || die "make failed"
}

