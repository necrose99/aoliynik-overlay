inherit font
DESCRIPTION="Ubuntu Font Family, sans-serif typeface hinted for clarity"
HOMEPAGE="http://font.ubuntu.com/"
SRC_URI="http://font.ubuntu.com/download/${PN}-${PV}+ufl.zip"

LICENSE="UFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

# Only installs fonts
RESTRICT="strip binchecks"
DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${P}"+ufl"
FONT_S="${S}"
FONT_SUFFIX="ttf"

