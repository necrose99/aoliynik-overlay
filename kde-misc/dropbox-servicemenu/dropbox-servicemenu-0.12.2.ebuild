# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/youtube-servicemenu/youtube-servicemenu-1.7-r1.ebuild,v 1.1 2010/04/17 08:15:13 reavertm Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python

MY_P="DropboxServiceMenu"
DESCRIPTION="Dropbox ServiceMenu is a servicemenu which allows easy access to most of Dropbox features. It uses Dropbox CLI to generate public urls, and pyndexer to allow sharing directories in public directory"
HOMEPAGE="http://kde-apps.org/content/show.php/Dropbox+ServiceMenu?content=124416"
SRC_URI="http://kde-apps.org/CONTENT/content-files/124416-${MY_P}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

RDEPEND="
	app-backup/dropbox-bin
	kde-base/klipper
	kde-base/kdialog
	dev-python/pysqlite
	dev-python/m2crypto
	x11-misc/xdg-utils
"

S="${WORKDIR}"
S="${WORKDIR}/${MY_P}-${PV}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	exeinto /usr/bin
	doexe dropbox-scripts/pyndexer.py || die
	doexe dropbox-scripts/dropbox.py || die 
	doexe dropbox-scripts/dropbox_menu.sh || die


	insinto /usr/share/kde4/services/ServiceMenus
	doins dropbox_all.desktop
	doins dropbox_files.desktop
	doins dropbox_directories.desktop
}
