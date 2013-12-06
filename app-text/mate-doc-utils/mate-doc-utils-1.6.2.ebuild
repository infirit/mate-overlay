# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit multilib python-r1 mate

DESCRIPTION="Documentation utilities for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=app-text/gnome-doc-utils-0.20.10
	>=dev-libs/libxml2-2.6.12[${PYTHON_USEDEP}]
	>=dev-libs/libxslt-1.1.8"

DEPEND="${RDEPEND}
	>=sys-apps/gawk-3
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	app-text/docbook-xml-dtd:4.4
	app-text/scrollkeeper-dtd
	app-text/rarian
	>=mate-base/mate-common-1.5.0"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	mate_src_prepare
	python_copy_sources
}

src_configure() {
	python_foreach_impl mate_src_configure
}

src_compile() {
	python_foreach_impl mate_src_compile
}

src_test() {
	python_foreach_impl mate_src_test
}

src_install() {
	python_foreach_impl mate_src_install

	# remove xml2po, already provided by gnome-doc-utils
	rm -rf "${ED}"usr/$(get_libdir)/python*/site-packages/xml2po || die
	rm -rf "${ED}"usr/bin/xml2po || die
	rm -rf "${ED}"usr/share/man/man*/xml2po* || die
	rm -rf "${ED}"usr/share/pkgconfig/xml2po* || die
	rm -rf "${ED}"usr/share/xml/mallard/*/mallard.{rnc,rng} || die
}
