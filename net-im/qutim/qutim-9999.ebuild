# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils qt4 subversion flag-o-matic
MY_PN="${PN/im/IM}"

DESCRIPTION="New Instant Messenger (ICQ) written in C++ with Qt."
HOMEPAGE="http://www.qutim.org"
LICENSE="GPL-2"
ESVN_REPO_URI="https://qutim.svn.sourceforge.net/svnroot/${PN}/trunk"

SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="|| ( $(qt4_min_version 4.3) x11-libs/qt-core )"
DEPEND="${RDEPEND}"
QT4_BUILT_WITH_USE_CHECK="png gif"

S="${WORKDIR}/${MY_PN}"

src_compile() {
	local rev=`LC_ALL=C svn export ${ESVN_REPO_URI} ${PN} | awk '$1=="Exported" && $2=="revision" { print $3}' | sed 's/.$//'`
	sed -i.orig "s/qutIM 0.1/qutIM 0.1+SVN${rev}/g" src/aboutinfo.ui || die "Sed failed"
	if use debug; then
		replace-flags -O* -O0
		append-flags -g -ggdb
	fi

	eqmake4 ${MY_PN}.pro || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install(){
	into /usr
	dobin build/bin/${MY_PN} || die "Installation failed"

	# Creating Desktop Entry. Thanks to hajit from qutim-forum for it.
	doicon icons/qutim_64.png || die "Failed to install icon"
	make_desktop_entry qutIM qutIM qutim_64.png "Network;InstantMessaging;Qt" || die "Failed to create a shourtcut"
}
