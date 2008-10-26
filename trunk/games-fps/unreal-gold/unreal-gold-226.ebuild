# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="Futuristic FPS (a hack that runs on top of Unreal Tournament)"
HOMEPAGE="http://www.unreal.com/ http://www.icculus.org/~ravage/unreal/unrealgold/"
SRC_URI="http://www.icculus.org/~ravage/unreal/unrealgold/unrealgold-install-436.run
	ftp://ftp.lokigames.com/pub/patches/ut/ut-install-436.run
	ftp://ftp.lokigames.com/pub/beta/ut/ut-install-436-GOTY.run
	ftp://ftp.lokigames.com/pub/patches/ut/IpDrv-436-Linux-08-20-02.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="nls"

UIDEPEND="!amd64? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		opengl? ( virtual/opengl )
		=media-libs/libsdl-1.2* )
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"
RDEPEND="opengl? ( virtual/opengl )"
DEPEND="${UIDEPEND}
	dev-util/xdelta
	sys-libs/lib-compat
	app-arch/unzip"

QA_TEXTRELS="*"

S="${WORKDIR}"

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	CDROM_SET_NAMES=("Unreal Tournament" "Unreal Gold")
	cdrom_get_cds Maps/UT-Logo-Map.unr:MAPS/UT-Logo-Map.unr.uz \
		MANUALS/Gold\ Manual\ addedum.doc

	unpack_makeself unrealgold-install-436.run
	unpack ./data.tar.gz
	mkdir ut
	cd ut
	case ${CDROM_SET} in
		0) unpack_makeself ut-install-436.run ;;
		1) unpack_makeself ut-install-436-GOTY.run ;;
	esac ;
	unpack IpDrv-436-Linux-08-20-02.zip
	unpack ./data.tar.gz
	unpack ./OpenGL.ini.tar.gz
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/unreal-gold
	dodir "${dir}"


	# the UT part

	# System files
	insinto "${dir}"/System
	doins "${CDROM_ROOT}"/System/*.{int,u}
	doins ut/IpDrv.so
	for x in ut/setup.data/data/System/*.0; do
		xdelta patch ${x} "${CDROM_ROOT}"/System/$(basename ${x} .0) ut/System/$(basename ${x} .0) ;
	done
	doins ut/System/*.{int,u,so,0,2}

	# copying Sounds
	insinto "${dir}"/Sounds
	doins "${CDROM_ROOT}"/Sounds/*.uax
	if use nls ; then
		doins "${CDROM_ROOT}"/Sounds/*.{est,frt,itt}_uax
	fi

	# copying Textures
	insinto "${dir}"/Textures
	doins "${CDROM_ROOT}"/Textures/{AlfaFX.utx,Ancient.utx,BluffFX.utx,castle1.utx,ChizraEFX.utx,Crypt.utx,DMeffects.utx,DecayedS.utx,Detail.utx,Female1Skins.utx,Female2Skins.utx,FireEng.utx,GenEarth.utx,GenFX.utx,GenFluid.utx,GenIn.utx,GenTerra.utx,GenWarp.utx,GreatFire.utx,GreatFire2.utx,HubEffects.utx,ISVFX.utx,JWSky.utx,LavaFX.utx,Liquids.utx,Male1Skins.utx,Male2Skins.utx,Male3Skins.utx,MenuGr.utx,Mine.utx,NaliCast.utx,NaliFX.utx,Palettes.utx,PlayrShp.utx,Queen.utx,Render.utx,ShaneDay.utx,ShaneSky.utx,SkTrooperSkins.utx,Skaarj.utx,SkyBox.utx,SkyCity.utx,SpaceFX.utx,Starship.utx,TCrystal.utx,Terranius.utx,UWindowFonts.utx,XFX.utx} ;


	# the Unreal part

	cdrom_load_next_cd

	# Unreal System stuff
	insinto "${dir}"/System
	doins System/* || die "Couldn't copy system data from Unreal Gold CD."

	exeinto "${dir}"/System
	doexe System/{ucc,unreal}-bin

	if use nls ; then
		insinto "${dir}"/System/
		doins "${CDROM_ROOT}"/System/*.{est,frt,itt,det} ||
			die	"Couldn't copy language data from Unreal Gold CD."
	fi

	xdelta patch setup.data/data/System/UPak.u.0 "${CDROM_ROOT}"/SYSTEM/UPak.u UPak.u
	doins UPak.u
	doins "${CDROM_ROOT}"/SYSTEM/UDSDemo.u

	# copying Maps
	insinto "${dir}"/Maps
	doins "${CDROM_ROOT}"/MAPS/*
	insinto "${dir}"/Maps/UPak
	doins "${CDROM_ROOT}"/MAPS/UPak/*

	# copying Help
	insinto "${dir}"/Help
	doins Help/*

	# copying Music
	insinto "${dir}"/Music
	doins "${CDROM_ROOT}"/MUSIC/*

	# repairing things
	for f in "${D}/${dir}"/{Maps,Maps/UPak}/Dm*.unr ; do
	mv ${f} ${f/Dm/DM-}
	done
	dosym Maps "${dir}"/maps

	# copying Sounds
	insinto "${dir}"/Sounds/
	doins "${CDROM_ROOT}"/Sounds/*.uax ||
		die "Couldn't copy Sounds from Unreal Gold CD."
	insinto "${dir}"/Sounds/int
	doins "${CDROM_ROOT}"/Sounds/int/* ||
		die "Couldn't copy Sounds from Unreal Gold CD."
	if use nls ; then
		for x in {det,est,frt,itt} ; do
			insinto "${dir}"/Sounds/${x}
			doins "${CDROM_ROOT}"/Sounds/${x}/* ||
				die "Couldn't copy Sounds from Unreal Gold CD."
		done
	fi

	# copying Textures from Unreal
	insinto "${dir}"/Textures
	doins "${CDROM_ROOT}"/Textures/{Credits,UGoldCredits,UPakFonts,Langs,Castle1}.utx

	# the main executables
	exeinto "${dir}"
	doexe bin/Linux/x86/glibc-2.1/ucc
	doexe bin/Linux/x86/glibc-2.1/unrealgold

	# and the rest

	# installing documentation/icon
	mv icon.xpm unrealgold.xpm
	insinto "${dir}"
	doins unrealgold.xpm README
	dodoc README || die "Couldn't install documentation."
	doicon unrealgold.xpm || die "Couldn't install icon."

	games_make_wrapper unrealgold ./unrealgold "${dir}" "${dir}"

	prepgamesdirs
}
