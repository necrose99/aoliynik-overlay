# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit kde4-base git
EGIT_REPO_URI="git://anongit.kde.org/oxygen-transparent"

DESCRIPTION="Oxygen style and decoration with support for transparency"
HOMEPAGE="http://kde-look.org/content/show.php?action=content&content=127752"
SRC_URI=""


LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

src_configure() {
	# these two are no-deps options
	# no need to have them useflaged
	mycmakeargs=(
	    -DCMAKE_BUILD_TYPE=release
	)

	kde4-base_src_configure
}

