# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN/compiz-plugins-}"

inherit flag-o-matic eutils

DESCRIPTION="Compiz Fusion Elements Plugin"
HOMEPAGE="http://www.elementsplugin.com"
SRC_URI="http://www.elementsplugin.com/downloads/elements-most-recent.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

PATCHES="${FILESDIR}/Makefile.patch
	${FILESDIR}/elements.c.patch"

RDEPEND="~x11-libs/compiz-bcop-${PV}
	~x11-wm/compiz-${PV}"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Makefile.patch
	epatch "${FILESDIR}"/elements.c.patch
}

src_compile() {
	filter-ldflags -znow -z,now
	filter-ldflags -Wl,-znow -Wl,-z,now

	sed -i 's/gen-schemas .*/gen-schemas :=/' Makefile
	emake || die "emake failed"
}

src_install() {
	cd "${S}"
	mkdir -p "${D}/usr/share/ccsm/images"
	mkdir -p "${D}/usr/share/ccsm/icons/hicolor/scalable/apps"
	cp ./images/* "${D}/usr/share/ccsm/images"
	cp ./images/plugin-elements.png "${D}/usr/share/ccsm/icons/hicolor/scalable/apps/plugin-elements.png"
	emake DESTDIR="${D}/usr/lib/compiz" XMLDIR="${D}/usr/share/compiz" install || die "emake install failed"
}

