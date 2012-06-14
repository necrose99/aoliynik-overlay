# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.0.0.68.ebuild,v 1.1 2008/04/03 16:18:00 humpback Exp $

inherit eutils qt4 pax-utils

DESCRIPTION="A P2P-VoiceIP client."
HOMEPAGE="http://www.skype.com/"

SRC_URI="http://download.skype.com/linux/${PN}_static-${PV}.tar.bz2"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		app-emulation/emul-linux-x86-compat )
	x86? ( >=sys-libs/glibc-2.4
		>=media-libs/alsa-lib-1.0.11
		x11-libs/libXScrnSaver
		x11-libs/libXv
		x11-libs/qt-dbus
		x11-libs/qt-webkit
		x11-libs/qt-gui
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp )"

RDEPEND="${DEPEND}"

QA_EXECSTACK="opt/skype/skype"
S=${WORKDIR}/${PN}_staticQT-${PV}

src_unpack() {
	unpack ${A}
}


src_install() {
	# remove mprotect() restrictions for PaX usage - see Bug 100507
	#pax-mark m "${S}"/skype

	exeinto /opt/${PN}
	doexe skype
	fowners root:audio /opt/skype/skype
	make_wrapper skype /opt/${PN}/skype /opt/${PN} /opt/${PN} /usr/bin

	insinto /opt/${PN}/sounds
	doins sounds/*.wav

	insinto /etc/dbus-1/system.d
	newins skype.conf skype.conf

	insinto /opt/${PN}/lang
	#
	#There have been some issues were lang is not updated from the .ts files
	#but if we have qt we can rebuild it
	#
	lrelease lang/*.ts

	doins lang/*.qm

	insinto /opt/${PN}/avatars
	doins avatars/*.png

	insinto /opt/${PN}
	for X in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}"/icons/SkypeBlue_${X}x${X}.png ${PN}.png
	done

	dodoc README

	# insinto /usr/share/applications/
	# doins skype.desktop
	make_desktop_entry "${PN} --disable-cleanlooks" "Skype VoIP" "${PN}" "Network;InstantMessaging;Telephony"

	#Fix for no sound notifications
	dosym /opt/${PN} /usr/share/${PN}

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
	# doexe skype-callto-handler
}
