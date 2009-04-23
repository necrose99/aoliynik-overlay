# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KDE_MINIMAL="4.1"

inherit kde4-base
MY_PN="gx_mail_notify"

DESCRIPTION="Plasmoid for checking unreaded e-mails."
HOMEPAGE="http://www.kde-look.org/content/show.php/GX+Mail+Notify?content=99617"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/99617-${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
SLOT="4.2"
IUSE="kdeprefix"
RESTRICT="mirror"
DEPEND="kde-base/plasma-workspace
        !kde-misc/plasmoids"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${MY_PN}-${PV}

