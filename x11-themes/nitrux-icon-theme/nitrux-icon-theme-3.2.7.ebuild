# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

MY_PN="nitrux"

DESCRIPTION="Nitrux for KDE"
HOMEPAGE="http://opendesktop.org/content/show.php/Nitrux+for+KDE?content=154498"
SRC_URI="http://store.nitrux.in/files/NITRUX-KDE.tar.gz -> ${P}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	insinto /usr/share/icons/${MY_PN}
	doins -r NITRUX-KDE/*
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
