# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils kde

# A well-used example of an eclass function that needs eutils is epatch. If
# your source needs patches applied, it's suggested to put your patch in the
# 'files' directory and use:
#
#   epatch ${FILESDIR}/patch-name-here
#
# eclasses tend to list descriptions of how to use their functions properly.
# take a look at /usr/portage/eclasses/ for more examples.

# Short one-line description of this package.
DESCRIPTION="Make your Kicker (the KDE main panel) rock with your music."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=52869"
SRC_URI="http://slaout.linux62.org/kirocker/${P}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"
