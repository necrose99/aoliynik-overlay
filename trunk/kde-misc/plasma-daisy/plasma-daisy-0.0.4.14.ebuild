# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="A simple application launcher for Plasma"
HOMEPAGE="http://lechio.freehostia.com/daisy.html"
LICENSE="GPL"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="4.2"

SRC_URI="http://lechio.freehostia.com/downloads/daisy-${PV}.tar.gz"

DEPEND="kde-base/kdelibs:${SLOT}"

S="${WORKDIR}/daisy-${PV}"