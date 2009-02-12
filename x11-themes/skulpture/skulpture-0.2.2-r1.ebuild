# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

CMAKE_IN_SOURCE_BUILD=ON
inherit cmake-utils qt4

DESCRIPTION="Widget style + kwin decoration. Skulpture aims to provide an easy
to the eyes 3D User interface."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=59031"
SRC_URI="http://skulpture.maxiom.de/releases/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""


DEPEND="|| ( x11-libs/qt-gui:4[dbus] <x11-libs/qt-4.4:4[dbus] )"
RDEPEND="${DEPEND}"
