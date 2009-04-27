# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-2.0.0.16.ebuild,v 1.6 2008/08/04 15:00:53 keytoaster Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 mozilla-launcher makeedit multilib mozextension autotools

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="ldap crypt bindist mozdom replytolist"
#IUSE="${IUSE} +xulrunner"

VER="3.0b2"
MOZ_URI="http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases/${VER}"
SRC_URI="${MOZ_URI}/source/thunderbird-${VER}-source.tar.bz2
		!xulrunner? ( mirror://gentoo/xulrunner-1.9.0.7.tar.bz2 )"

RDEPEND=">=sys-devel/binutils-2.16.1
        >=dev-libs/nss-3.12
        >=dev-libs/nspr-4.7.1
        >=media-libs/lcms-1.17
        >=app-text/hunspell-1.1.9
        xulrunner? ( >=net-libs/xulrunner-1.9${MY_PV} )"

PDEPEND="crypt? ( >=x11-plugins/enigmail-0.95.6-r4 )
		replytolist? ( x11-plugins/replytolist )"

S="${WORKDIR}"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=mail
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

pkg_setup(){
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Pango is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge pango."
		die "Pango needs X"
	fi

	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi

	use moznopango && warn_mozilla_launcher_stub
}

src_unpack() {
	unpack thunderbird-${VER}-source.tar.bz2

	cd "${S}"
	eautoreconf

}

src_compile() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	if !mozconfig_init; then
		elog "mozconfig file wasn't found in the mail directory. We'll create"
		elog "our own."
		touch mail/config/mozconfig
		mozconfig_init
	fi
	mozconfig_config

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	mozconfig_annotate 'apparently required' --enable-application=mail
	#mozconfig_annotate '' --with-system-nspr
	#mozconfig_annotate '' --with-system-nss

	# Bug 223375, 217805
	# Breaks builds with gcc-4.3
	#if [[ $(gcc-version) == "4.3" ]]; then
	#	mozconfig_annotate 'gcc-4.3 breaks builds' --disable-optimize
	#fi

	# Bug #72667
	if use mozdom; then
		mozconfig_annotate '' --enable-extensions=default,inspector
	else
		mozconfig_annotate '' --enable-extensions=default
	fi

	if ! use bindist; then
		mozconfig_annotate '' --enable-official-branding
	fi

	if use xulrunner; then
		# Add xulrunner variable
		mozconfig_annotate '' --with-libxul-sdk=/usr/$(get_libdir)/xulrunner-1.9
	fi

	# Finalize and report settings
	mozconfig_final

	# -fstack-protector breaks us
	if gcc-version ge 4 1; then
		gcc-specs-ssp && append-flags -fno-stack-protector
	else
		gcc-specs-ssp && append-flags -fno-stack-protector-all
	fi
		filter-flags -fstack-protector -fstack-protector-all

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	
	make -f client.mk configure
	econf || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	elog "Removing old installs with some really ugly code.  It potentially"
	elog "eliminates any problems during the install, however suggestions to"
	elog "replace this are highly welcome.  Send comments and suggestions to"
	elog "mozilla@gentoo.org."
	rm -rf "${ROOT}"/"${MOZILLA_FIVE_HOME}"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Most of the installation happens here
	dodir "${MOZILLA_FIVE_HOME}"
	cp -RL "${S}"/mozilla/dist/bin/* "${D}"/"${MOZILLA_FIVE_HOME}"/ || die "cp failed"

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp "${D}"${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		"${D}"${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/thunderbird
	install_mozilla_launcher_stub thunderbird ${MOZILLA_FIVE_HOME}

	if ! use bindist; then
		doicon "${FILESDIR}"/icon/thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		doicon "${FILESDIR}"/icon/thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop
	fi

	# Install files necessary for applications to build against thunderbird
	elog "Installing includes and idl files..."
	cp -LfR "${S}"/mozilla/dist/include "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"
	cp -LfR "${S}"/mozilla/dist/idl "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"

	# Dirty hack to get some applications using this header running
	dosym "${MOZILLA_FIVE_HOME}"/include/necko/nsIURI.h \
		"${MOZILLA_FIVE_HOME}"/include/nsIURI.h

	# Warn user that remerging enigmail is neccessary on USE=crypt
	use crypt && ewarn "Please remerge x11-plugins/enigmail after updating ${PN}."
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	update_mozilla_launcher_symlinks
}
