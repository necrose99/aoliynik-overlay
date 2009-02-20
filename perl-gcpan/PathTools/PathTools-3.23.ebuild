# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.13.02

inherit perl-module

S=${WORKDIR}/PathTools-3.23
DESCRIPTION="Handling files and directories portably"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/PathTools-3.23.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc sparc-fbsd x86 x86-fbsd"

DEPEND="perl-core/Scalar-List-Utils
	dev-perl/module-build"
