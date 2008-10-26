# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.9.1-r1.ebuild,v 1.5 2008/08/17 00:00:30 mr_bones_ Exp $

EAPI=1
inherit toolchain-funcs eutils qt4

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/freetype
	dev-libs/boost
	media-libs/jpeg
	net-misc/curl
	|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 x11-libs/qt-script:4 x11-libs/qt-opengl:4 )  =x11-libs/qt-4.3*:4 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6
	nls? ( sys-devel/gettext )
	x11-libs/libXt"

# bug #186194
QT4_BUILT_WITH_USE_CHECK="opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use nls ; then
		sed -i \
			-e 's/ENABLE_NLS 1/ENABLE_NLS 0/' \
			CMakeLists.txt \
			|| die "sed failed"
	fi
}

src_compile() {
	CC=$(tc-getCC) \
	CXX=$(tc-getCXX) \
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		|| die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use nls || rm -rf "${D}/usr/share/locale"
	newicon data/icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} Stellarium /usr/share/pixmaps/${PN}.bmp "Education;Science;Astronomy;"
	dodoc AUTHORS ChangeLog README
}
