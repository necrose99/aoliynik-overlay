# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
MY_PN="qOrganizer"
DESCRIPTION="qOrganizer"
HOMEPAGE="http://qorganizer.sf.net/"
SRC_URI="http://surfnet.dl.sourceforge.net/sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64"
IUSE="dbus nls"

RDEPEND=">=x11-libs/qt-gui-4.5
	>=x11-libs/qt-webkit-4.5"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"
src_compile() {
	cd src
	qmake|| die "qmake failed"
	emake || die "emake failed"
}
src_install() {
	cd ${S}

	dodir /usr/bin
	exeinto /usr/bin
	doexe src/ ${MY_PN}

	dodir /usr/share/applnk/Office

        echo "[Desktop Entry]
        Encoding=UTF-8
        Type=Application
        Exec=qOrganizer
        Icon=qOrganizer.png
        Comment=Organizer
        Name=qOrganizer
        Terminal=false
        GenericName=Organizer" > ${D}/usr/share/applnk/Office/qorganizer.desktop


	
	dodir /usr/share/icons
	insinto /usr/share/icons
	doins ${MY_PN}.png
}
