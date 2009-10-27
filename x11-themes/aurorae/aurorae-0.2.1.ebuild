# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

CONTENT_NUMBER="107158"

DESCRIPTION="Aurorae is a theme engine for KDE 4.3 KWin window decorations."
HOMEPAGE="http://www.kde-look.org/content/show.php/Aurorae+Theme+Engine?content=107158"
LICENSE="GPL"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="4.3"

SRC_URI="http://www.kde-look.org/CONTENT/content-files/${CONTENT_NUMBER}-aurorae-${PV}.tar.gz"

DEPEND="kde-base/kdelibs:${SLOT}"

S="${WORKDIR}/${PN}"

src_prepare() {
    kde4-base_src_prepare
    sed -i 's/${KDE4WORKSPACE_KDECORATIONS_LIBS}/kdecorations/g' src/CMakeLists.txt || die "Patching failed!" 
}
