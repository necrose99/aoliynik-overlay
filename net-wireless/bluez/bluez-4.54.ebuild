# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez/bluez-4.39-r1.ebuild,v 1.1 2009/09/05 11:59:29 patrick Exp $

EAPI="2"

inherit autotools multilib eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sh ~sparc ~x86"

IUSE="alsa cups debug doc gstreamer old-daemons +pam pcmcia test-programs usb"

CDEPEND="alsa? ( media-libs/alsa-lib )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10 )
	usb? ( dev-libs/libusb )
	cups? ( net-print/cups )
	>=sys-fs/udev-146
	dev-libs/glib
	sys-apps/dbus
	media-libs/libsndfile
	>=dev-libs/libnl-1.1
	!net-wireless/bluez-libs
	!net-wireless/bluez-utils"
DEPEND="sys-devel/flex
	>=dev-util/pkgconfig-0.20
	doc? ( dev-util/gtk-doc )
	sys-devel/bison
	${CDEPEND}"
RDEPEND="${CDEPEND}
	pam? ( sys-auth/pambase[consolekit] )
	test-programs? (
		dev-python/dbus-python
		dev-python/pygobject )"

src_prepare() {
	epatch	"${FILESDIR}/bluez-plugdev.patch"

	if use cups; then
		epatch "${FILESDIR}/4.50-cups-location.patch"
	fi

	# needed for both patches
	eautoreconf
}

src_configure() {
	econf \
		--enable-network \
		--enable-serial \
		--enable-input \
		--enable-audio \
		--enable-service \
		$(use_enable gstreamer) \
		$(use_enable alsa) \
		$(use_enable usb) \
		--enable-netlink \
		--enable-tools \
		--enable-bccmd \
		--enable-hid2hci \
		--enable-dfutool \
		$(use_enable old-daemons hidd) \
		$(use_enable old-daemons pand) \
		$(use_enable old-daemons dund) \
		$(use_enable cups) \
		$(use_enable test-programs test) \
		--enable-udevrules \
		--enable-configfiles \
		$(use_enable pcmcia) \
		$(use_enable debug) \
		--localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README || die

	# don't install useless .la files
	find "${D}" -type f -name '*.la' -delete || die "failed to remove .la files"

	if use test-programs ; then
		cd "${S}/test"
		dobin simple-agent simple-service monitor-bluetooth
		newbin list-devices list-bluetooth-devices
		for b in apitest hsmicro hsplay test-* ; do
			newbin "${b}" "bluez-${b}"
		done
		insinto /usr/share/doc/${PF}/test-services
		doins service-*

		cd "${S}"
	fi

	if use old-daemons; then
		newconfd "${FILESDIR}/4.18/conf.d-hidd" hidd || die
		newinitd "${FILESDIR}/4.18/init.d-hidd" hidd || die
	fi

	insinto /etc/bluetooth
	doins \
		input/input.conf \
		audio/audio.conf \
		network/network.conf \
		|| die
}

pkg_postinst() {
	udevadm control --reload_rules && udevadm trigger --subsystem-match=bluetooth

	elog
	elog "To use dial up networking you must install net-dialup/ppp."
	elog ""
	elog "For a password agent, there is for example net-wireless/bluez-gnome"
	elog "for gnome and net-wireless/kdebluetooth for kde."
	elog ""
	elog "Use the old-daemons use flag to get the old daemons like hidd"
	elog "installed. Please note that the init script doesn't stop the old"
	elog "daemons after you update it so it's recommended to run:"
	elog "  /etc/init.d/bluetooth stop"
	elog "before updating your configuration files or you can manually kill"
	elog "the extra daemons you previously enabled in /etc/conf.d/bluetooth."
	if use pam; then
		elog ""
		elog "If you want to use rfcomm as a normal user, you need to add the user"
		elog "to the uucp group."
	fi
	elog ""
	if use old-daemons; then
		elog "The hidd init script was installed because you have the old-daemons"
		elog "use flag on. It is not started by default via udev so please add it"
		elog "to the required runleves using rc-update <runlevel> add hidd. If"
		elog "you need init scripts for the other daemons, please file requests"
		elog "to https://bugs.gentoo.org."
	else
		elog "The bluetooth service should be started automatically by udev"
		elog "when the required hardware is inserted next time."
	fi
	elog
	if ! use pam; then
		ewarn "Since you have the pam use flag disabled for this package, you will only be "
		ewarn "able to run bluetooth clients as root.  If you want to be able to run bluetooth "
		ewarn "clients as a regular user, you must enable the pam use flag for this package."
	fi
}
