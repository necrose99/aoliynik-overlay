# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KLV=59031
MY_PN=skulpture
S="${WORKDIR}/${MY_PN}-${PV}"

inherit eutils
DESCRIPTION="Skulpture is a GUI style addon for Qt 4.3 or newer. It features a classical three-dimensional artwork with shadows and smooth gradients to enhance the visual experience."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://skulpture.maxiom.de/releases/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.3"
RDEPEND="$DEPEND"

src_compile()
{
    cmake -DCMAKE_INSTALL_PREFIX=/usr/kde/4.1 -DCMAKE_BUILD_TYPE=Release .
    make
}



src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog README TODO
}
