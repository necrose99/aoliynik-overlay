# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils autotools qt4
MY_PN="${PN/handbrake/HandBrake}"
MY_P="${P/handbrake/HandBrake}"

DESCRIPTION="Open-source DVD to MPEG-4 converter."
HOMEPAGE="http://handbrake.m0k.org/"
SLOT="0"
LICENSE="GPL-2"

CONTRIB="
a52dec-0.7.4
faac-1.24
ffmpeg-9816
lame-3.96.1
libdca-r81-strapped
libdvdcss-1.2.9
libdvdread-0.9.7
libmkv-0.6.1.3
libogg-1.1.2
libsamplerate-0.1.2
libvorbis-aotuv_b5
mpeg2dec-0.4.1
libquicktime-0.9.10
mpeg4ip-1.3
zlib-1.2.3
x264-r736
xvidcore-1.1.2
"

SRC_URI="http://download.m0k.org/handbrake/releases/${MY_P}.tar.gz"

for X in ${CONTRIB} ; do
	SRC_URI="${SRC_URI}
		http://download.m0k.org/handbrake/contrib/${X}.tar.gz"
done

KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="nomirror"

RDEPEND="sys-libs/zlib
$(qt4_min_version 4.3.3)
"

DEPEND="dev-util/jam
    ${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
    unpack "${MY_P}.tar.gz"
    #cp ${DISTFILES}
    for X in ${CONTRIB} ; do
	CP=${X/-*/}    
	cd ${S}
	cp "${DISTDIR}/${X}.tar.gz" "${S}/contrib/${CP}.tar.gz"
	cd  "${S}/contrib"
	tar  xzf "${CP}.tar.gz" || die "Failed to unpack ${CP}" 
	[ ! -d ${CP} -a -d "${X}" ] && einfo "Renaming ${X} to ${CP}" && mv "${X}" "${CP}"
	cd "${CP}" && [ ! -x ./configure ] && einfo "Autoconf for ${CP}" && aclocal && autoconf && cd "${S}/contrib"
	#Always repackage
	(rm -f "${S}/contrib/${CP}.tar.gz" && tar -C "${S}/contrib" -czf "${S}/contrib/${CP}.tar.gz" "${CP}") || die "Failed to repackage ${CP}"
	einfo "Repackaged ${CP}"
	rm -rf "${S}/contrib/${CP}"
    done
}

src_compile() {
    einfo "Configuring HandBrake."
    cd "${S}"
    ./configure || die "configure HandBrake failed"
    einfo "Building HandBrake."
    jam || die "jam HandBrake failed"
    cd ${S}/qt4
    eqmake4 qtHB.pro
    emake 
}

src_install() {
    # Not really much to install :)
    into /usr
    dobin HandBrakeCLI
    dobin qt4/qtHB
    
    dodoc AUTHORS BUILD CREDITS NEWS THANKS TRANSLATIONS
}
