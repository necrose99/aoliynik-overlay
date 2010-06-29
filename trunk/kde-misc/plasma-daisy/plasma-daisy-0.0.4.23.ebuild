# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_PN="plasma-applet-daisy"
DESCRIPTION="A simple application launcher for Plasma"
HOMEPAGE="http://cdlszm.org"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

SRC_URI="http://cdlszm.org/downloads/${MY_PN}-${PV}.tar.gz"
DEPEND=">=kde-base/kdelibs-4.2"

S="${WORKDIR}/${MY_PN}-${PV}"
