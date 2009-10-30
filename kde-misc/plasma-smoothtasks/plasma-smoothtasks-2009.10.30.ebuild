# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_LINGUAS="cs de fr hu pl ru"
inherit kde4-base

MY_P="smooth-tasks-src-wip-2009-10-30"

DESCRIPTION="Smooth Tasks Plasmoid"
HOMEPAGE="http://www.kde-look.org/content/show.php/Smooth+Tasks?content=101586"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/101586-${MY_P}.tar.bz2"

LICENSE="GPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"
RESTRICT="nomirror"


RDEPEND="
	>=kde-base/plasma-workspace-${KDE_MINIMAL}
"

S="${WORKDIR}/${MY_P}"

