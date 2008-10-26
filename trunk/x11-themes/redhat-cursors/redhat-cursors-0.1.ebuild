# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gentoo-xcursors/gentoo-xcursors-0.3.1.ebuild,v 1.16 2006/07/23 17:17:29 flameeyes Exp $

KLV=53266

DESCRIPTION="Red Hat Bluecurve cursors from Fedora 4 and Fedora 6 with KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KLV}-${PN}.tar.bz2"


LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""


RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/redhat-cursors"

src_install() {
	dodir /usr/share/cursors/xorg-x11
	cp -pPR ${S}/* ${D}/usr/share/cursors/xorg-x11/ || die
}

