# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Plays video as your wallpaper"
HOMEPAGE="http://kde-look.org/content/show.php/Animated+Video+Wallpaper?content=112105"
SRC_URI="http://kde-look.org/CONTENT/content-files/112105-${PN}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	>=kde-base/plasma-workspace-4.3
"
S=${WORKDIR}/${PN}


