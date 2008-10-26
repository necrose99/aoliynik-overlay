# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SRC="${P/-/_}"
SRC="${SRC/_p/+cvs}"

DESCRIPTION="Utilities for video fx that can be used with Kino"
HOMEPAGE="https://launchpad.net/ubuntu/hardy/+source/smilutils/"
SRC_URI="https://launchpad.net/ubuntu/hardy/+source/smilutils/0.3.2+cvs20070731-3/+files/smilutils_0.3.2+cvs20070731.orig.tar.gz"
#RESTRICT="nomirror"
IUSE="ffmpeg vorbis mp3"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}/${PN}"

DEPEND="
    >=media-video/ffmpeg-0.4.9_p20070616
    >=media-libs/libdca-0.0.5
    >=media-libs/libdv-1.0.0-r2
    >=media-libs/imlib2-1.4.0
    >=sys-devel/libtool-1.5.24
    >=media-libs/libogg-1.1.3
    >=media-libs/libsdl-1.2.11-r2
    >=sys-devel/libtool-1.5.24
    vorbis? ( >=media-libs/libvorbis-1.2.0 )
    mp3? ( media-sound/lame )
    >=dev-libs/libxml2-2.6.30-r1"
#>=x11-libs/gtk+-2.12.1-r2
#>=media-libs/libquicktime-1.0.2


src_compile() {
    einfo "Running autogen.sh"
    ./autogen.sh || die "autogen.sh failed"

    #CPPFLAGS="${CPPFLAGS} -fpermissive"
    #CPPFLAGS=`echo ${CPPFLAGS} | xargs`\
    ECONF_SOURCE="${S}" econf \
        --disable-dependency-tracking \
        --disable-debug \
        $(use_enable vorbis) \
        $(use_enable mp3 mp3lame) \
        \#$(use_with ffmpeg avcodec) \
        || die "configure failed!"

    emake || die "make failed!"
}

src_install() {
    make DESTDIR=${D} install || die
}
