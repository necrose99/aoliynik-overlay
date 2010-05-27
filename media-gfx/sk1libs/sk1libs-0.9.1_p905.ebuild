# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

MY_PV="${PV/_p/pre_rev}"
DESCRIPTION="set of python non-GUI extensions for sK1 Project"
HOMEPAGE="http://www.sk1project.org"
SRC_URI="http://sk1project.org/downloads/sk1/${MY_PV}/${PN}-${MY_PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/imaging[tk]
	>=media-libs/lcms-1.15[python]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P%_p*}"
