# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
MATE_LA_PUNT="yes"
GCONF_DEBUG="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit mate python-r1

DESCRIPTION="Unicode character map viewer"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cjk +introspection python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND=">=dev-libs/glib-2.16.3[${PYTHON_USEDEP}]
	>=x11-libs/pango-1.2.1
	x11-libs/gtk+:2
	introspection? ( >=dev-libs/gobject-introspection-0.6 )
	python? ( >=dev-python/pygtk-2.7.1[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=app-text/mate-doc-utils-1.2.1[${PYTHON_USEDEP}]
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-gtk=2.0
		$(use_enable introspection)
		$(use_enable cjk unihan)
		$(use_enable python python-bindings)"
	DOCS="ChangeLog NEWS README TODO"
}

src_prepare() {
	# Fix test
	sed -i 's/gucharmap/mucharmap/g' po/POTFILES.in || die
	mate_src_prepare
}
