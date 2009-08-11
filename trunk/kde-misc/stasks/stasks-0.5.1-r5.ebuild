# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE plasmoid. Shows an icon-only taskbar"
HOMEPAGE="http://kde-look.org/content/show.php/STasks+patched?content=101586"
SRC_URI="http://bitbucket.org/panzi/stasks-patched-by-panzi/get/c1e8b7dcfa9a.zip -> ${P}-2009-08-10a.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	!kde-plasmoids/stasks
	>=kde-base/plasma-workspace-4.3
"
S=${WORKDIR}/${PN}-patched-by-panzi

#PATCHES=(
#	"${FILESDIR}/${P}-peek.patch"
#)
