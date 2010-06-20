# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit kde4-base

DESCRIPTION="A window decoration for KDE4"
HOMEPAGE="http://kde-look.org/content/show.php/Smaragd+%28Emerald+for+KDE%29?content=125162"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/125162-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/kwin-${KDE_MINIMAL}
	x11-libs/cairo
"

S=${WORKDIR}/${P}

