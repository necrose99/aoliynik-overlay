# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#LANGS=" ar cs da de el en_CA en_GB es fi fr gl it kk nb oc pl pt_BR pt ro ru sk sv tr uk zh_CN zh_TW"

inherit cmake-utils gnome2-utils

DESCRIPTION="A modern music player and library organizer based on Amarok 1.4 and Qt4"
HOMEPAGE="http://code.google.com/p/clementine-player/"
SRC_URI="http://clementine-player.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="projectm"
#IUSE+=" ${LANGS// / linguas_}"

COMMON_DEPEND="
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-sql:4[sqlite]
	>=media-libs/taglib-1.6
	media-libs/liblastfm
	dev-libs/glib:2
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
"
# now only presets are used, libprojectm is internal
# http://code.google.com/p/clementine-player/source/browse/#svn/trunk/3rdparty/libprojectm/patches
RDEPEND="${COMMON_DEPEND}
	projectm? ( >=media-libs/libprojectm-1.2.0 )
	>=media-plugins/gst-plugins-meta-0.10
	>=media-plugins/gst-plugins-gio-0.10
	>=media-plugins/gst-plugins-soup-0.10
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.39
	dev-util/pkgconfig
"

DOCS="Changelog TODO"

src_configure() {
	# Broken, http://code.google.com/p/clementine-player/issues/detail?id=441
	# linguas
	#local langs
	#for x in ${LANGS}; do
	#	use linguas_${x} && langs+="${x} "
	#done
	#	-DLINGUAS="${langs}"

	# Now build fails without gstreamer engine, so choice of other engines is useless.
	mycmakeargs=(
		"-DBUNDLE_PROJECTM_PRESETS=OFF"
		$(cmake-utils_use projectm ENABLE_VISUALISATIONS)
		"-DENGINE_GSTREAMER_ENABLED=ON"
		"-DENGINE_QT_PHONON_ENABLED=OFF"
		"-DENGINE_LIBVLC_ENABLED=OFF"
		"-DENGINE_LIBXINE_ENABLED=OFF"
		)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
