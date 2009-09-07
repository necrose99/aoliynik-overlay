# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE plasmoid. Shows an icon-only taskbar"
HOMEPAGE="http://kde-look.org/content/show.php/Smooth+Tasks?content=101586"
SRC_URI="http://bitbucket.org/panzi/smooth-tasks/get/e23aca5d9a04.bz2 -> ${P}-2009-09-06.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/stasks
	!kde-misc/stasks
	>=kde-base/plasma-workspace-4.3
"
S=${WORKDIR}/${PN}
