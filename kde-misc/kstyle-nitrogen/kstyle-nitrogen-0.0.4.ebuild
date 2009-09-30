# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /phenix/u/hpereira/repository/kde/kde4-kstyle-nitrogen/nitrogen.ebuild,v 1.1 2009/09/26 22:07:09 hpereira Exp $

EAPI="2"

inherit kde4-base

MY_P="kde4-${P}-Source"

DESCRIPTION="A window decoration for KDE 4.2.x"
HOMEPAGE="http://kde-look.org/content/show.php/Nitrogen-style?content=112652"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/112652-${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
