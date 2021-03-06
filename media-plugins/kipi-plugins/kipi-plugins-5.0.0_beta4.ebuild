# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KDE_HANDBOOK=true
	KDE_TEST=true
fi

inherit kde5

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="calendar expoblending flashexport mediawiki panorama phonon viewers vkontakte"

if [[ ${KDE_BUILD_TYPE} != live ]]; then

	MY_PV=${PV/_/-}
	MY_P="digikam-${MY_PV}"

	SRC_BRANCH=stable
	[[ ${PV} =~ beta[0-9]$ ]] && SRC_BRANCH=unstable
	SRC_URI="mirror://kde/${SRC_BRANCH}/digikam/${MY_P}.tar.bz2"

	S=${WORKDIR}/${MY_P}/extra/${PN}

fi

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	$(add_qt_dep qtxmlpatterns)
	kde-apps/libkipi:5=
	calendar? ( $(add_kdeapps_dep kcalcore) )
	flashexport? ( $(add_frameworks_dep karchive) )
	mediawiki? ( net-libs/libmediawiki:5 )
	panorama? ( $(add_frameworks_dep threadweaver) )
	phonon? ( media-libs/phonon[qt5] )
	viewers? (
		$(add_qt_dep qtopengl)
		x11-libs/libX11
		x11-libs/libXrandr
		virtual/opengl
	)
	vkontakte? ( net-libs/libkvkontakte:5 )
"

DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	panorama? (
		sys-devel/bison
		sys-devel/flex
	)
"

RDEPEND="${COMMON_DEPEND}
	!media-plugins/kipi-plugins:4
	expoblending? ( media-gfx/hugin )
	panorama? (
		media-gfx/enblend
		media-gfx/hugin
	)
"

RESTRICT=test

src_prepare() {

	undetect_lib() {
		local _use=${1}
		local _name=${2}
		[[ -z ${_name} ]] && _name=$(echo ${_use} | sed 's/./\U&/g')
		use $_use || \
			sed -i -e "/DETECT_LIB${_name}/d" CMakeLists.txt || die
	}

	undetect_lib mediawiki
	undetect_lib vkontakte KVKONTAKTE

	sed -i -e "/add_subdirectory(expoblending)/ s/^/#DONT/" CMakeLists.txt || die

	if [[ ${KDE_BUILD_TYPE} != live ]]; then
		# prepare the handbook
		mv "${WORKDIR}"/${MY_P}/doc/${PN} "${S}"/doc || die

		if use handbook; then
			echo "add_subdirectory( doc )" >> CMakeLists.txt || die
		fi

		if [[ ${SRC_BRANCH} != unstable ]]; then
			# prepare the translations
			mv "${WORKDIR}/${MY_P}/po" po || die
			find po -name "*.po" -and -not -name "kipiplugin*.po" -delete || die
			echo "find_package(Msgfmt REQUIRED)" >> CMakeLists.txt || die
			echo "find_package(Gettext REQUIRED)" >> CMakeLists.txt || die
			echo "add_subdirectory( po )" >> CMakeLists.txt || die
		fi
	fi

	kde5_src_prepare

}

src_configure() {

	local mycmakeargs=(
		$(cmake-utils_use_find_package calendar KF5CalendarCore)
		$(cmake-utils_use_find_package flashexport KF5Archive)
		$(cmake-utils_use_find_package panorama BISON)
		$(cmake-utils_use_find_package panorama FLEX)
		$(cmake-utils_use_find_package panorama KF5ThreadWeaver)
		$(cmake-utils_use_find_package phonon Phonon4Qt5)
		$(cmake-utils_use_find_package viewers OpenGL)
		$(cmake-utils_use_find_package viewers Qt5OpenGL)
		$(cmake-utils_use_find_package viewers X11)
	)

	kde5_src_configure

}
