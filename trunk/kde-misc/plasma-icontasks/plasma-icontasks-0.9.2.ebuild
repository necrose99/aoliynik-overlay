# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_LINGUAS="es hu it fr pl ru tr pt_BR zh_CN"

inherit kde4-base

CONTENT_NUMBER="144808"

DESCRIPTION="Icon Tasks Plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php/?content=144808"
LICENSE="GPL-3"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="dockmanager"

SRC_URI="http://kde-look.org/CONTENT/content-files/${CONTENT_NUMBER}-${P}.tar.bz2"

DEPEND="kde-base/kdelibs"
RDEPEND="
dockmanager? ( x11-misc/dockmanager )
"

S="${WORKDIR}/${P}"
