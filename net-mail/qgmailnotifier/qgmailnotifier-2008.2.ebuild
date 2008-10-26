# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A QT Based GMail Notifier"
HOMEPAGE="http://www.codef00.com/projects.php#QGMailNotifier"
SRC_URI="http://www.codef00.com/projects/qgmailnotifier-${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip mirror"
DEPEND=">=x11-libs/qt-4.3.0"
RDEPEND="${DEPEND}"
S="${WORKDIR}/qgmailnotifier"

src_compile() {
	qmake -makefile || dir "qmake failed"
	emake || die "emake failed"
}

src_install() {
	make INSTALL_ROOT=${D}/usr/ install
}


