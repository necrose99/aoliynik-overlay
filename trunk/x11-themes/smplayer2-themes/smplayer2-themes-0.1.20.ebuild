# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smplayer-themes/smplayer-themes-0.1.20.ebuild,v 1.1 2010/01/20 18:43:12 yngwin Exp $

DESCRIPTION="Icon themes for smplayer2"
HOMEPAGE="http://smplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/smplayer/smplayer-themes-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="media-video/smplayer2"

# Override it as default will call make that will catch the install target...
src_compile() {
	return
}

S="${WORKDIR}/smplayer-themes-${PV}"

src_install() {
	insinto /usr/share/smplayer2
	doins -r themes || die "Failed to install themes"
	dodoc Changelog README.txt || die
}
