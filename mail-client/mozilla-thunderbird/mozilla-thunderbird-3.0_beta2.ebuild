# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-2.0.0.16.ebuild,v 1.6 2008/08/04 15:00:53 keytoaster Exp $
EAPI="2"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 mozilla-launcher makeedit multilib mozextension autotools


MY_PV2="${PV/_beta/b}"
MY_P="${P/_beta/b}"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="ldap crypt bindist mozdom replytolist"

REL_URI="http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases"
SRC_URI="${REL_URI}/${MY_PV2}/source/thunderbird-${MY_PV2}-source.tar.bz2"

RDEPEND=">=sys-devel/binutils-2.16.1
        >=dev-libs/nss-3.12.2
        >=dev-libs/nspr-4.7.3
	>=dev-db/sqlite-3.6.10
        >=media-libs/lcms-1.17
        >=app-text/hunspell-1.2
	x11-libs/cairo[X]
	x11-libs/pango[X]"

S="${WORKDIR}"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

pkg_setup(){
	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi
}

src_unpack() {
	unpack ${A}

	# Remove the patches we don't need
#	use xulrunner && rm "${WORKDIR}"/patch/*noxul* || rm "${WORKDIR}"/patch/*xulonly*
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${FILESDIR}"/${PV}

	eautoreconf

	cd mozilla
	eautoreconf
	cd js/src
	eautoreconf

	# We need to re-patch this because autoreconf overwrites it
#	epatch "${WORKDIR}"/patch/000_flex-configure-LANG.patch
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	touch mail/config/mozconfig
	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=mail
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	#mozconfig_annotate '' --with-system-nspr
	#mozconfig_annotate '' --with-system-nss

	# Bug #72667
	if use mozdom; then
		MEXTENSIONS="${MEXTENSIONS},inspector"
	fi

	if ! use bindist; then
		mozconfig_annotate '' --enable-official-branding
	fi

	# Finalize and report settings
	mozconfig_final

	####################################
	#
	#  Configure and build
	#
	####################################

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die
}

src_compile() {
	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/usr/bin/thunderbird

	if ! use bindist; then
		newicon "${S}"/other-licenses/branding/thunderbird/content/icon48.png thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		newicon "${S}"/mail/base/content/icon48.png thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop
	fi

	# Create /usr/bin/thunderbird
	make_wrapper thunderbird "${MOZILLA_FIVE_HOME}/thunderbird"

	# Warn user that remerging enigmail is neccessary on USE=crypt
#	use crypt && ewarn "Please remerge x11-plugins/enigmail after updating ${PN}."
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
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
