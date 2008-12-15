## Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Qt4 GUI for wine (W.I.N.E)"
HOMEPAGE="http://sourceforge.net/projects/q4wine/"
SRC_URI="http://heanet.dl.sourceforge.net/sourceforge/q4wine/$P.tar.gz
http://kent.dl.sourceforge.net/sourceforge/q4wine/$P.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.3.3"

RDEPEND="${DEPEND}
	app-admin/sudo
	app-emulation/wine
	>=dev-db/sqlite-3.5.6
	>=sys-apps/which-2.19
	>=media-gfx/icoutils-0.26.0"

pkg_setup() {
    if ! built_with_use -a x11-libs/qt-sql:4 sqlite ; then
        ewarn "q4wine uses sqlite database."
        ewarn "You must emerge x11-libs/qt-sql:4 with sqlite support."
        ewarn "Please USE=\"sqlite\" emerge x11-libs/qt-sql:4"
        die "Cannot emerge without sqlite USE flags on x11-libs/qt-sql:4"
    fi
}

src_compile() {
	cd ${S}
	qmake || die "make failed"
    make || die "make failed"
}

src_install() {
	dodir /usr/share/q4wine/theme/nuvola/data
	insinto /usr/share/q4wine/theme/nuvola/data
	doins src/theme/nuvola/data/*
	dodir /usr/share/q4wine/i18n/
	insinto /usr/share/q4wine/i18n/
	# FIXME: it might be used LINGUAS here, is it'n?
	doins src/i18n/*.qm
	insinto /usr/
	dobin q4wine
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




