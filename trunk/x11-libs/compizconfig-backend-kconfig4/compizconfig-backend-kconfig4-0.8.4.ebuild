# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde4-base

DESCRIPTION="Compizconfig Kconfig4 Backend"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="~x11-libs/libcompizconfig-${PV}
	~x11-wm/compiz-${PV}
	>=kde-base/kdelibs-4.3
"
RDEPEND="${DEPEND}"
