# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /phenix/u/hpereira/repository/kde/kde4-windeco-nitrogen/nitrogen.ebuild,v 1.1 2009/05/26 21:55:20 hpereira Exp $

EAPI="2"

inherit kde4-base

MY_PN="jinliu-${PN}-f3f16ba"

DESCRIPTION="A Chromium-like window decoration for KDE 4"
HOMEPAGE="http://www.kde-look.org/content/show.php/Nitrogen?content=119069"
SRC_URI="http://github.com/jinliu/kwin-deco-chromi/tarball/v${PV} -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
