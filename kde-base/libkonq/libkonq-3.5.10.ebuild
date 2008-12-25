# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-3.5.8.ebuild,v 1.1 2007/10/19 23:50:59 philantrop Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility pertty"

if use pertty;
then
	PATCHES="$FILESDIR/$KMNAME-3.5.7-$PN-tooltip.patch
		 $FILESDIR/$KMNAME-3.5.6-$PN-execute_feedback.patch"
fi

pkg_setup() {
	kde_pkg_setup
	if use pertty && ! built_with_use --missing true =kde-base/kdelibs-3.5* pertty; then
		eerror "The pertty USE flag in this package enables special extensions"
		eerror "and requires that Kdelibs be patched to support these extensions."
		eerror "Since it appears your version of Kdelibs was not compiled with these"
		eerror "extensions, you must either emerge libkonq without pertty or"
		eerror "re-emerge Kdelibs with pertty enabled and then emerge libkonq again."
		die "Missing pertty USE flag on kde-base/kdelibs"
	fi
}
