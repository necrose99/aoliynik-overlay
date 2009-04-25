# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picasa/picasa-2.2.2820.5.ebuild,v 1.9 2007/10/17 00:29:11 wolf31o2 Exp $

inherit eutils versionator rpm

MY_P="picasa-$(replace_version_separator 3 '-')"
DESCRIPTION="Google's photo organizer"
HOMEPAGE="http://picasa.google.com"
SRC_URI="http://dl.google.com/linux/rpm/testing/i386/picasa-3.0-current.i386.rpm"
LICENSE="google-picasa"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="mirror strip"
QA_TEXTRELS_x86="opt/google/picasa/wine/lib/wine/set_lang.exe.so
		opt/google/picasa/wine/lib/wine/browser_prompt.exe.so
		opt/google/picasa/wine/lib/wine/license.exe.so"
#QA_EXECSTACK_x86="opt/picasa/bin/xsu
#               opt/picasa/wine/bin/wine
#               opt/picasa/wine/bin/wineserver
#               opt/picasa/wine/bin/wine-pthread
#               opt/picasa/wine/bin/wine-kthread
#               opt/picasa/wine/lib/*
#               opt/picasa/wine/lib/wine/*"

RDEPEND="x86? (
		dev-libs/atk
		dev-libs/glib
		dev-libs/libxml2
		sys-libs/zlib
		x11-libs/gtk+
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXt
		x11-libs/pango )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs )"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack "${A}"
}

src_install() {
	cd opt/google/picasa/3.0

	dodir /opt/netscape/plugins
	mv lib/npPicasa3.so "${D}/opt/netscape/plugins/"

	dodir /opt/google/picasa
	mv bin wine "${D}/opt/google/picasa/"

	dodir /usr/bin
	for i in picasa picasafontcfg mediadetector showpicasascreensaver; do
		dosym /opt/google/picasa/bin/${i} /usr/bin/${i}
	done

	dodoc README LICENSE.FOSS

	cd desktop

	mv picasa.desktop.template picasa.desktop
	mv picasa-fontcfg.desktop.template picasa-fontcfg.desktop

	sed -i -e "s:EXEC:picasa:" picasa.desktop
	sed -i -e "s:ICON:picasa.xpm:" picasa.desktop
	sed -i -e "s:EXEC:picasafontcfg:" picasa-fontcfg.desktop
	sed -i -e "s:ICON:picasa-fontcfg.xpm:" picasa-fontcfg.desktop

	doicon picasa.xpm picasa-fontcfg.xpm
	domenu {picasa{,-fontcfg},picasascr}.desktop
}

