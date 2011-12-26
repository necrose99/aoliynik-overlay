# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/smplayer-themes/smplayer-themes-0.1.20.ebuild,v 1.1 2010/01/20 18:43:12 yngwin Exp $

DESCRIPTION="Lightness BURG theme"
HOMEPAGE="http://www.omgubuntu.co.uk/2010/10/lightness-burg-theme/"
SRC_URI="http://fc00.deviantart.net/fs70/f/2010/276/d/9/lightness_for_burg_by_sworiginal-d301ctu.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-boot/burg"
RDEPEND="sys-boot/burg"

S="${WORKDIR}/"

# Override it as default will call make that will catch the install target...
src_compile() {
	return
}

src_install() {
	dodir /boot/burg/themes
	cp -pPR ${S}/* ${D}/boot/burg/themes/ || die
}
