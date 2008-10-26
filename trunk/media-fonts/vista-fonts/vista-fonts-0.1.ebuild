DESCRIPTION="Original Vista Fonts"
HOMEPAGE="http://www.arcong.ath.cx/"
SRC_URI="mirror://sourceforge/arcon/vista-fonts.tar.bz2"

LICENSE="MSttfEULA"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="nostrip"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}
