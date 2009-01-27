# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils subversion

ESVN_REPO_URI="http://xbmc-addons.googlecode.com/svn/packages/plugins/programs/"
DESCRIPTION="Plugin installer for the XBMC media-player and entertainment hub"
HOMEPAGE="http://xbmc-addons.googlecode.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-video/xbmc"
DEPEND="${RDEPEND}"

src_unpack() {
	subversion_src_unpack

	unzip "${S}/SVN_Repo_Installer.zip"

	# XBMC will see Plugins in '/usr/share/xbmc/plugins/{music,pictures,videos}' #
	# if /usr/share/xbmc/plugins/ is chmod'd -R 777 #
	# But will only see '...plugins/programs/' if it is in '~/.xbmc/plugins/programs/' #

	# XBMC's virtual filesystem to real filesystem mapping is as follows: #
	# P:\\	->	T:\\ for master profile, or T:\\profiles\profile_name for other profiles
	# Q:\\	->	/usr/share/xbmc/
	# T:\\	->	~/.xbmc/userdata/
	# U:\\	->	~/.xbmc/
	# Z:\\	->	/tmp/xbmc-<user>/

	# User installed scripts/plugins should only be installed in "~/.xbmc/{scripts,plugins}" #
	sed -e 's/Q:\\\\/U:\\\\/g' \
		-i "${S}/SVN Repo Installer/installerAPI/xbmcplugin_downloader.py" || \
			die "Sed failed for ${S}/SVN Repo Installer/installerAPI/xbmcplugin_downloader.py"
}

src_install() {
	dodir "/usr/share/xbmc/plugins/programs/XBMC-Addons Installer"
	cp -R "${S}/SVN Repo Installer"/* "${D}/usr/share/xbmc/plugins/programs/XBMC-Addons Installer"
}

pkg_postinst() {
	elog
	elog "To access the plugin installer you need to do"
	elog "'ln -s /usr/share/xbmc/plugins/programs ~/.xbmc/plugins/programs'"
	elog "as the user running XBMC."
	elog "To access the plugin installer using XBMC's default skin,"
	elog "enable the 'Programs' menu via"
	elog "Settings > Skin Settings > Home Window > Show Programs in Main Menu"
	elog
	elog "This is an installer only, to remove plugins installed by it you will need to"
	elog "'rm -rf ~/.xbmc/plugins/<category>/<plugin>/' as the user running XBMC"
	elog
}
