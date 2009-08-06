# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License

#net-p2p/eiskaltdc/eiskaltdc-0.5.ebuild

inherit qt4

DESCRIPTION="Qt based client for DirectConnect, fork of Valknut"
HOMEPAGE="https://sourceforge.net/projects/eiskaltdc/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ssl"

RDEPEND="|| ( x11-libs/qt-gui:4 =x11-libs/qt-4.3*:4 )
	>=dev-libs/libxml2-2.4.22
	>=net-p2p/dclib-0.3.23
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_with ssl) \
		--with-libdc=/usr \
		--with-qt-dir=${QTDIR} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
