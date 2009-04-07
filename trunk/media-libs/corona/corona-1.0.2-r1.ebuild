# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/local/cvsroot/stealer-gentoo-portage/media-libs/corona/corona-1.0.2.ebuild,v 1.2 2004/02/02 20:55:11 sven Exp $

DESCRIPTION="Corona is an image reading/writing library for C++"
HOMEPAGE="http://corona.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE="jpeg png debug"
DEPEND="sys-libs/glibc
	png? ( >=media-libs/libpng-1.2.5-r4 )
	jpeg? ( >=media-libs/jpeg-6b-r3 )"

src_compile() {
	econf `use_enable debug` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"

	dodoc doc/*.txt
}
