# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.1"
inherit kde4-base


DESCRIPTION="Open-source speech recognition program"
HOMEPAGE="http://simon-listens.org/index.php?id=122&L=1"
SRC_URI="mirror://sourceforge/speech2text/${P}-Source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!app-accessibility/julius
	sys-devel/flex
	media-libs/portaudio"
RDEPEND=""

S="${WORKDIR}/${P}-Source"
