# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Created by Alex Barker (abarker@callutheran.edu)

inherit eutils libtool versionator linux-info

DESCRIPTION="Juniper Networks SSL VPN"
HOMEPAGE="http://www.juniper.net/products_and_services/ssl_vpn_secure_access/"
SRC_URI=""

LICENSE="Juniper"
# The license is unclear.
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
    dev-libs/openssl
    sys-libs/lib-compat
    sys-libs/zlib
    >=virtual/jre-1.4.2
    x11-libs/openmotif
    app-arch/rpm"

pkg_setup() {
    # Setup kernel info for query.
    linux-info_pkg_setup	
    
    ebegin "Checking for Univesal TUN/TAP device driver support"
    linux_chkconfig_present TUN
    eend $?
    
    if [[ $? -ne 0 ]] ; then
	eerror "${DESCRIPTION} requires TUN/TAP support!"
	eerror "Please enable TUN/TAP support in your kernel config, found at:"
	eerror
	eerror "  Device Drivers-->"
	eerror "    Network device support-->"
	eerror "      <M> Univesal TUN/TAP device driver support"
	eerror
	eerror "and recompile your kernel ..."
	die "TUN/TAP support not detected!"
    fi
}

src_install() {
    # Default location and version number for libs.
    LIBCRYPT_LOC="/usr/lib"
    
    # Create Lib Location
    mkdir -p ${D}/${LIBCRYPT_LOC}
    
    # This is a dirty hack becaues they are called different 
    # names on redhat 9.
    ln -s libssl.so ${D}/${LIBCRYPT_LOC}/libssl.so.2
    ln -s libcrypto.so ${D}/${LIBCRYPT_LOC}/libcrypto.so.2
    
    # Add the following to /etc/ld.so.conf and then run ldconfig
    mkdir -p ${D}/etc/env.d/
    echo "LDPATH=\"/usr/X11R6/lib\"" >> ${D}/etc/env.d/99JuniperVPN
}

pkg_postinst() {
    einfo ""
    einfo "please be sure to remove any juniper networking information in your home directory."
    einfo "  rm -rf ~/.juniper_networks."
    einfo ""
}

