# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cvs eutils

DESCRIPTION="Use a movie or screensaver as the desktop background on XGL"
HOMEPAGE="http://webcvs.freedesktop.org/xapps/xwinwrap/"
KEYWORDS="~amd64 ~ppc ~x86"

LICENSE="OSI-Approved"
SLOT="0"

DEPEND=">=x11-libs/libX11-1.0.3
	>=media-libs/mesa-6.5"

RDEPEND="${DEPEND}"

ECVS_SERVER="anoncvs.freedesktop.org:/cvs/xapps"
ECVS_MODULE="xwinwrap"
ECVS_BRANCH=""
ECVS_LOCALNAME="xwinwrap"
ECVS_CO_DATE=${PV##*alpha}
ECVS_UP_OPTS="-D ${ECVS_CO_DATE} -dP"
ECVS_CO_OPTS="-D ${ECVS_CO_DATE}"

S="${WORKDIR}"/${ECVS_LOCALNAME}

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/xwinwrap-frameless-geometry.patch"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xwinwrap
}
