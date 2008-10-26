# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4 toolchain-funcs

DESCRIPTION="Winamp-like audio player written with Qt4"
HOMEPAGE="http://qmmp.ylsoftware.com/"
SRC_URI="http://qmmp.ylsoftware.com/files/${P}.tar.bz2"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa jack flac musepack ffmpeg mad vorbis pulseaudio wavpack modplug sndfile"

RDEPEND="$(qt4_min_version 4.3)
		mad? ( >=media-libs/libmad-0.15.1b )
		vorbis? ( >=media-libs/libvorbis-1.1.2 )
		alsa? ( >=media-libs/alsa-lib-1.0.1 )
		>=media-libs/taglib-1.4
		>=net-misc/curl-7.16
		flac? ( >=media-libs/flac-1.1.3 )
		musepack? ( >=media-libs/libmpcdec-1.2.6 )
		jack? ( >=media-sound/jack-audio-connection-kit-0.102.5 
				>=media-libs/libsamplerate-0.1.2 )
		modplug? ( >=media-libs/libmodplug-0.8.4 )
		sndfile? ( >=media-libs/libsndfile-1.0.17 )
		wavpack? ( >=media-sound/wavpack-4.41 )
		pulseaudio? ( >=media-sound/pulseaudio-0.9.9 )
		ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20070330 )"
			
DEPEND="${RDEPEND}
		>=dev-util/cmake-2.4.8"

src_compile() {
	CMAKEOPTS="-DCMAKE_INSTALL_PREFIX=/usr"
	einfo "Enabled plugins:"
	if use jack; then
		einfo "  JACK"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_JACK:BOOL=FALSE"
	fi
	if use alsa; then
		einfo "  ALSA"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_ALSA:BOOL=FALSE"
	fi
	if use flac; then
		einfo "  FLAC"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_FLAC:BOOL=FALSE"
	fi
	if use vorbis; then
		einfo "  Ogg Vorbis"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_VORBIS:BOOL=FALSE"
	fi
	if use musepack; then
		einfo "  Musepack"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_MPC:BOOL=FALSE"
	fi
	if use mad; then
		einfo "  MAD"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_MAD:BOOL=FALSE"
	fi
	if use ffmpeg; then
		einfo "  FFmpeg"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_FFMPEG:BOOL=FALSE"
	fi

	if use pulseaudio; then
		einfo "  PulseAudio"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_PULSE:BOOL=FALSE"
	fi

	if use sndfile; then
		einfo "  SndFile"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_SNDFILE:BOOL=FALSE"
	fi

	if use modplug; then
		einfo "  Modplug"
	else
		CMAKEOPTS="${CMAKEOPTS} -DUSE_MODPLUG:BOOL=FALSE"
	fi




	cmake ${CMAKEOPTS} || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	dodoc COPYING README README.RUS AUTHORS ChangeLog ChangeLog.rus
}
