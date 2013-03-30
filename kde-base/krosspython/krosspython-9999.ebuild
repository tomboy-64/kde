# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kross-interpreters"
KMMODULE="python"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit python-single-r1 kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS=""
IUSE="debug"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-meta_pkg_setup
}
