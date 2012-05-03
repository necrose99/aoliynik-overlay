# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-2.0.14.ebuild,v 1.9 2011/06/04 18:52:06 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
#PYTHON_USE_WITH="ssl"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="google-docs-fs-${PV}rc1"

DESCRIPTION="A filesystem to access Google Docs using any computer"
HOMEPAGE="http://code.google.com/p/google-docs-fs/"
SRC_URI="http://google-docs-fs.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/gdata-2.0.14
	>=dev-python/fuse-python-0.2.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

