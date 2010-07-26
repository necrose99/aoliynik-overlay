# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="Oxygen style and decoration with support for transparency"
HOMEPAGE="http://kde-look.org/content/show.php?action=content&content=127752"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/playground/artwork/oxygen-transparent"

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

