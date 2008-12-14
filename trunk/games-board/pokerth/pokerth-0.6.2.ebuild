# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils games qt4

MY_PN=PokerTH
S="${WORKDIR}/${MY_PN}-${PV}-src"

DESCRIPTION="Texas Hold'em poker game."
HOMEPAGE="http://www.pokerth.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.3.2:4
	>=net-misc/curl-7.16
	>=dev-libs/boost-1.34.1
	>=net-libs/gnutls-2.2.2
	media-libs/libsdl
	media-libs/sdl-mixer"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use "media-libs/sdl-mixer" mikmod ; then
	eerror "media-libs/sdl-mixer has to be compiled with USE=mikmod"
	die "Needed USE-flag for sdl-mixer not found."
	fi
	games_pkg_setup
}

src_compile() {
	cd "${S}"
	sed -i -e "/targets.path/s:/usr/bin:${GAMES_BINDIR}:" pokerth_game.pro || die "sed failed."
	sed -i -e "/data.path/s:/usr/share:${GAMES_DATADIR}:" pokerth_game.pro || die "sed failed."

	eqmake4
	emake || die "emake failed."
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed."
	insinto "${GAMES_DATADIR}/${PN}/data"
	doins -r data/* || die "doins data failed."

	newicon pokerth.png "${PN}.png"
	make_desktop_entry "${PN}" "PokerTH" "${PN}.png" || die "make_desktop_entry failed."

	prepgamesdirs
}
