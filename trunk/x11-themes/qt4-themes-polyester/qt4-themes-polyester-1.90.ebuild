# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

KLV=27968
MY_PN=polyester
S="${WORKDIR}/${MY_PN}-${PV}/style"

inherit eutils
DESCRIPTION="Polyester GUI style plugin for Qt4"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="http://www.notmart.org/files/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.3"
RDEPEND="$DEPEND"

src_compile()
{
    qmake qmake.pro
    make
}



src_install () {
	make INSTALL_ROOT=${D} install || die "make install failed"
}
