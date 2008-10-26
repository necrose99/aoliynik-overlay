# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

MY_PN="KGmailNotifier"
KV=55375

MY_PV="${PV/_beta/-beta}"
PN="${PN}-${MY_PV}"

S=${WORKDIR}/${MY_P}

DESCRIPTION="KGmailNotifier is a gmail notifier applet written for KDE using Python and PyKDE/PyQt"
HOMEPAGE="http://kde-apps.org/content/show.php/${MY_PN}?content=${KV}"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${KV}-${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"
RESTRICT="nomirror"

need-kde 3.4

S=${WORKDIR}/${MY_PN}
