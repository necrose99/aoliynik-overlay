# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="Large Vocabulary Continuous Speech Recognition Engine"
HOMEPAGE="http://julius.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/julius/36530/${P}.tar.gz"

LICENSE="julius"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa esd sndfile"

DEPEND="sys-libs/zlib
	sys-devel/flex
	alsa? ( media-libs/alsa-lib )
	!alsa? ( esd? ( media-sound/esound ) )
	sndfile? ( media-libs/libsndfile )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	local myconf
	tc-export CC

	if use alsa ; then
		myconf="${myconf} --with-mictype=alsa"
	elif use esd ; then
		myconf="${myconf} --with-mictype=esd"
	else
		myconf="${myconf} --with-mictype=oss"
	fi

	econf \
		$(use_with sndfile) \
		${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install  || die

	dodoc ChangeLog *.txt
}
