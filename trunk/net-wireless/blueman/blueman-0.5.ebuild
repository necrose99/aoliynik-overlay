# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit gnome2 eutils

DESCRIPTION="Full featured bluetooth manager for GNOME/GTK"
HOMEPAGE="http://blueman.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/blueman/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12
dev-python/pyrex
dev-python/pybluez
dev-python/python-distutils-extra
dev-python/setuptools

dev-python/notify-python
>=net-wireless/bluez-utils-3.9
net-wireless/bluez-libs
>=net-wireless/bluez-utils-3.20
net-wireless/gnome-bluetooth
dev-python/pynotifier
gnome-base/gnome-vfs
"

DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}_${PV}"

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

