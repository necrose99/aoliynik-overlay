# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="GTK+ bluetooth management utility."
HOMEPAGE="http://blueman.tuxfamily.org"

ESVN_REPO_URI="svn://svn.tuxfamily.org/svnroot/blueman/svn/trunk"
ESVN_PROJECT="blueman"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/pybluez 
		>=dev-lang/python-2.5.1
		dev-python/notify-python
		dev-python/pygtk
		>=net-wireless/bluez-libs-3.25
		>=net-wireless/bluez-utils-3.25"
RDEPEND="net-wireless/gnome-bluetooth
		 gnome-base/nautilus
		 gnome-extra/gnome-vfs-obexftp"


src_compile() {
	cd ${S}
	python setup.py build
}

src_install() {
	python setup.py install --prefix=${D}/usr
	D_PATH=$(echo $D | sed 's/[/]/\\\//g')
	sed -i "s/${D_PATH}/\//" `find ${D} -name constants.py`
	sed -i "s/${D_PATH}/\//" `find ${D} -name blueman.desktop`
	rm -f `find $D -name constants.pyc`
}
