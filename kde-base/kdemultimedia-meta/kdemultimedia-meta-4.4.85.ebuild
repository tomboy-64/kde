# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit kde4-functions

DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua ffmpeg kdeprefix"

RDEPEND="
	$(add_kdebase_dep dragonplayer)
	$(add_kdebase_dep juk)
	$(add_kdebase_dep kdemultimedia-kioslaves)
	$(add_kdebase_dep kmix)
	$(add_kdebase_dep kscd)
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	$(add_kdebase_dep mplayerthumbs)
	ffmpeg? ( $(add_kdebase_dep ffmpegthumbs) )
	$(block_other_slots)
"
