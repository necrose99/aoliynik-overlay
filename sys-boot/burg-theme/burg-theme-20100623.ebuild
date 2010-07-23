# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smplayer-themes/smplayer-themes-0.1.20.ebuild,v 1.1 2010/01/20 18:43:12 yngwin Exp $

DESCRIPTION="Themes for BURG"
HOMEPAGE="http://code.google.com/p/burg/"
SRC_URI="http://burg.googlecode.com/files/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-boot/burg"
RDEPEND="sys-boot/burg"

# Override it as default will call make that will catch the install target...
src_compile() {
	return
}

src_install() {
	insinto /boot/burg
	doins -r themes || die "Failed to install themes"
	doins -r fonts || die "Failed to install fonts"
	doins gui.cfg
	doins burgenv

}
