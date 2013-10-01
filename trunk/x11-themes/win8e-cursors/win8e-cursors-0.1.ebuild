# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gentoo-xcursors/gentoo-xcursors-0.3.1.ebuild,v 1.16 2006/07/23 17:17:29 flameeyes Exp $

KLV=160758
MY_PN=Win8E
DESCRIPTION="For lovers of aero cursor theme Windows 8"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KLV}-${MY_PN}.tar.gz"


LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""


RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

src_install() {
	dodir /usr/share/cursors/${MY_PN}
	cp -pPR ${S}/* ${D}/usr/share/cursors/${MY_PN}/ || die
}

