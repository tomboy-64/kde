# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

CMAKE_MIN_VERSION="3.0.0"
inherit kde5

DESCRIPTION="KDE control module for systemd"
HOMEPAGE="https://projects.kde.org/projects/playground/sysadmin/systemd-kcm"

IUSE=""
LICENSE="GPL-2+"
KEYWORDS=""

DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	>=dev-libs/boost-1.45
	sys-apps/systemd
"
RDEPEND="${DEPEND}
	!kde-misc/kcmsystemd:4
"
