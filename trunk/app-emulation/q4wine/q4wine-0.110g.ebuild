## Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils

DESCRIPTION="Qt4 GUI for wine (W.I.N.E)"
HOMEPAGE="http://sourceforge.net/projects/q4wine/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/qt:4 x11-libs/qt-gui:4 x11-libs/qt-core:4 x11-libs/qt-sql:4[sqlite]"
LANGS=""

# FIXME: it might be used LINGUAS here
# but CMakeList.txt not support it now (i will add it in v0.111)
# LANGS="ru en uk"
#
#for X in ${LANGS}; do
#    IUSE="${IUSE} linguas_${X}"
#done

RDEPEND="${DEPEND}
	>=dev-util/cmake-2.6.2[qt4]
	app-admin/sudo
	app-emulation/wine
	>=dev-db/sqlite-3.5.6
	>=sys-apps/which-2.19
	>=media-gfx/icoutils-0.26.0"

src_compile() {
	cd ${S}/
	cmake -DCMAKE_INSTALL_PREFIX=/usr . || die "cmake failed"
    emake || die "emake failed"
}

src_install() {
	# FIXME: it might be used LINGUAS here
	# but CMakeList.txt not support it now (i add it in v 0.111)
	# local LANG=
	# for LANG in ${LINGUAS}; do
	#	#if has ${LANG} ${LANGS}; then
	#	echo {$LANG} {$LINGUAS}
	# done
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	elog "Utility for management wine applications and prefixes"
	elog "(C) 2008-2009, brezblock core team"
	elog "http://brezblock.org.ua/"
	elog
	elog "To start q4wine, run:"
	elog "$ q4wine"
	elog
	elog "To allow user mount and umount cdrom and loop images:"
	elog "Run: visudo as root"
	elog "And add following line:"
	elog "YOUR_USERNAME localhost = NOPASSWD: /bin/mount, /bin/umount"
	elog "Note: For more details see man sudoers"
}




