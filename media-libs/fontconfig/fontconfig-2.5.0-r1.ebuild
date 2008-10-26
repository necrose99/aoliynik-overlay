# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils libtool autotools

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.gz"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc xml +ubuntu"

RDEPEND="newspr? ( >=media-libs/freetype-2.3.5-r2 )
		 !newspr? ( media-libs/freetype:2 )
		 !xml? ( dev-libs/expat )
		 xml? ( dev-libs/libxml2:2 )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		doc? ( app-text/docbook-sgml-utils )"
PDEPEND="app-admin/eselect-fontconfig"

pkg_setup () {
	if use ubuntu && \
		! built_with_use --missing false media-libs/freetype:2 ubuntu; then
		eerror "You need to compile freetype-2 with the ubuntu USE before you can compile fontconfig with the ubuntu USE flag."
		die "Please rebuild freetype-2 with ubuntu enabled."
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	# add docbook switch so we can disable it
	epatch "${FILESDIR}"/${PN}-2.3.2-docbook.patch
	epatch "${FILESDIR}"/${P}-libtool-2.2.patch #213831 Fix libtool-2.2 brekage

	# Enable control over freetype's sub-pixel configuration; currently, this
	# only has an effect on cairo, and only if it contains the patch from
	# freedesktop #10301. This will be included in fontconfig 2.6. See
	# freedesktop #13566.
	if use ubuntu; then
		epatch "${FILESDIR}"/${PN}-2.5.0-ubuntu-3.diff
		epatch "${FILESDIR}"/${PN}-lcd-filtering.patch
		epatch "${FILESDIR}"/${PN}-monospace-lcd-filtering.patch
		epatch "${FILESDIR}"/${PN}-hinting-and-alising-confs.patch
		cp "${FILESDIR}"/30-replace-bitmap-fonts.conf conf.d/
	fi

	eautoreconf
	epunt_cxx #74077
}

src_compile() {
	# I'm thinking this should be removed
	[[ ${ARCH} == alpha && ${CC} == ccc ]] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	# disable docs only disables local docs generation, they come with the tarball
	econf $(use_enable doc docs) \
		$(use_enable doc docbook) \
		--localstatedir=/var \
		--with-docdir=/usr/share/doc/${PF} \
		--with-default-fonts=/usr/share/fonts \
		--with-add-fonts=/usr/local/share/fonts \
		$(use_enable xml libxml2) \
		|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	insinto /etc/fonts
	doins "${S}"/fonts.conf

	newman doc/fonts-conf.5 fonts.conf.5
	dohtml doc/fontconfig-user.html
	dodoc doc/fontconfig-user.{txt,pdf}

	if use doc; then
		doman doc/Fc*.3
		dohtml doc/fontconfig-devel.html doc
		dohtml -r doc/fontconfig-devel
		dodoc doc/fontconfig-devel.{txt,pdf}
	fi

	dodoc AUTHORS ChangeLog NEWS README

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig
}

pkg_postinst() {
	echo
	ewarn "Please make fontconfig configuration changes in /etc/fonts/conf.d/"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	echo

	if [[ ${ROOT} = / ]]; then
		ebegin "Creating global font cache..."
		/usr/bin/fc-cache -sr
		eend $?
	fi
}
