# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI=2

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnViewMP-linux.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	|| ( >=x11-libs/qt-4.3.0:4 ( x11-libs/qt-gui:4 ) )"
DEPEND=""

RESTRICT="strip"
S="${WORKDIR}/XnViewMP"
INSTALL_DIR="/opt/xnview"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:./xnview:${INSTALL_DIR}/xnview  \"\$\@\":" xnview.sh || die
	sed -i -e "s:LD_LIBRARY_PATH=./:LD_LIBRARY_PATH=${INSTALL_DIR}:" xnview.sh || die
}

src_install() {

	dodir ${INSTALL_DIR}
	insinto ${INSTALL_DIR}
	doins ${S}/*

	exeinto ${INSTALL_DIR}
	doexe xnview
	doexe xnview.sh

	exeinto /usr/bin
	newexe xnview.sh xnview

	insinto /usr/share/applications/
	doins ${FILESDIR}/xnview.desktop

	insinto /usr/share/icons/
	doins ${FILESDIR}/xnview.png
}
