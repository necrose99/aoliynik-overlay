# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"
KDE_MINIMAL="4.3"

inherit kde4-base

DESCRIPTION="A KDE4 Plasma Applet. A variation of the KAlgebra plasmoid that makes use of the Qalculate! library."
HOME_PAGE="http://www.kde-look.org/content/show.php/Qalculate?content=84618"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/84618-qalculate_applet-${PV}.tar.gz"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE="kdeprefix"
RESTRICT="mirror"
DEPEND="
    	sci-libs/libqalculate
	kde-base/plasma-workspace
        !kde-misc/plasmoids"
RDEPEND="${DEPEND}"

S=${WORKDIR}/qalculate_applet-${PV}

