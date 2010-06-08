# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="Store, Sync and Share Files Online"
HOMEPAGE="http://www.dropbox.com/"
SRC_URI="x86? 	( http://dl-web.dropbox.com/u/17/${PN/bin/lnx}.x86-${PV}.tar.gz )
	amd64?	( http://dl-web.dropbox.com/u/17/${PN/bin/lnx}.x86_64-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.14"
DEPEND="${RDEPEND}"
#	dev-python/docutils
#	dev-util/pkgconfig"

DOCS="ACKNOWLEDGEMENTS VERSION"


pkg_setup() {
	enewgroup dropbox
	enewuser dropbox -1 -1 /opt/${PN} dropbox
}

src_prepare() {
	mv .dropbox-dist ${P}

	# remove shipped libstdc++.so.6 as it does not provide LIBCXX_3.4.11
	# and it seems to work alright with the one from >=gcc-4
	rm ${S}/libstdc++.so.6 || die "rm libstdc++.so.6 failed"
}

src_install() {
	# Blame the craptastic software
	mkdir -p ${D}/opt/${PN}/bin
	cp -rf * ${D}/opt/${PN}/bin
	mkdir ${D}/opt/${PN}/Dropbox
	
	#into /opt/${PN}
	#dolib.so *.so*
	#dobin dropbox
	
	#insinto /opt/${PN}/bin
	#doins library.zip
	#doins -r ncrypt-*	
	#doins -r netifaces-*

	exeinto /opt/bin
	doexe "${FILESDIR}"/dropboxd

	newconfd "${FILESDIR}"/dropboxd.confd dropboxd
	newinitd "${FILESDIR}"/dropboxd.initd dropboxd

	fowners -R dropbox:dropbox /opt/${PN} || die
	fperms o-rwx /opt/${PN} || die

	fowners dropbox:dropbox /opt/bin/dropboxd || die
	fperms o-rwx /opt/bin/dropboxd || die
}

pkg_postinst() {
	ewarn
	ewarn "You still need to create a .dropbox configuration folder after"
	ewarn "the installation.  Install this package on a computer with a "
	ewarn "GUI and run /opt/bin/dropboxd.  Follow the instructions and "
	ewarn "just leave the dropbox folder location where it defaults to."
	ewarn "Now move the ~/.dropbox folder it created to /opt/dropbox-bin "
	ewarn "on the machine that will be running the daemon."
	ewarn 
	ewarn "\t/opt/bin/dropbox"
	ewarn "\tmv ~/.dropbox /opt/dropbox-bin/"
	ewarn

	elog
	elog "If you've installed this manually, Remove ~/.dropbox-dist now."
	elog
	elog "You should start the daemon automatically:"
	elog "\trc-update add dropboxd default"
	elog
}
