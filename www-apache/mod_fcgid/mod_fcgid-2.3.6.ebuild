# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-2.3.6.ebuild,v 1.3 2011/01/11 17:52:02 xarthisius Exp $

inherit apache-module eutils multilib

DESCRIPTION="mod_fcgid is a binary-compatible alternative to mod_fastcgi with better process management."
HOMEPAGE="http://httpd.apache.org/mod_fcgid/"
SRC_URI="mirror://apache/httpd/mod_fcgid/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

APACHE2_MOD_CONF="2.4/20_${PN}"
APACHE2_MOD_DEFINE="FCGID"

DOCFILES="CHANGES-FCGID README-FCGID STATUS-FCGID"

need_apache

src_compile () {
	./configure.apxs || die "apxs configure failed!"
	make || die "make failed"
	ln -sf modules/fcgid/.libs .libs || die "symlink creation failed"
}
