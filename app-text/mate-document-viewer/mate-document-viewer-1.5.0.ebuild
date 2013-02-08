# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
MATE_LA_PUNT="yes"

inherit mate

DESCRIPTION="Atril document viewer for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="caja dbus debug djvu dvi +introspection mate mate-keyring +ps t1lib tiff"

# Since 2.26.2, can handle poppler without cairo support. Make it optional ?
# not mature enough
RDEPEND="
	>=dev-libs/glib-2.25.11:2
	>=dev-libs/libxml2-2.5:2
	x11-libs/gtk+:2[introspection?]
	>=x11-libs/libSM-1
	|| (
		>=x11-themes/mate-icon-theme-1.2.0
		>=x11-themes/hicolor-icon-theme-0.10 )
	>=x11-libs/cairo-1.9.10
	>=app-text/poppler-0.14[cairo]
	djvu? ( >=app-text/djvu-3.5.17 )
	dvi? (
		virtual/tex-base
		t1lib? ( >=media-libs/t1lib-5.0.0 ) )
	mate? ( >=mate-base/mate-conf-1.2.1[introspection?] )
	mate-keyring? ( >=mate-base/mate-keyring-1.2.1 )
	introspection? ( >=dev-libs/gobject-introspection-0.6 )
	caja? ( >=mate-base/mate-file-manager-1.2.2[introspection?] )
	ps? ( >=app-text/libspectre-0.2.0 )
	tiff? ( >=media-libs/tiff-3.6:0 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/mate-doc-utils-1.2.1
	~app-text/docbook-xml-dtd-4.1.2
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.35"

ELTCONF="--portage"

pkg_setup() {
	# Passing --disable-help would drop offline help, that would be inconsistent
	# with helps of the most of Gnome apps that doesn't require network for that.
	G2CONF="${G2CONF}
		--disable-tests
		--enable-pdf
		--enable-comics
		--enable-impress
		--enable-thumbnailer
		--enable-pixbuf
		--with-smclient=xsmp
		--with-platform=mate
		--enable-help
		$(use_enable dbus)
		$(use_enable djvu)
		$(use_enable dvi)
		$(use_with mate mateconf)
		$(use_with mate-keyring keyring)
		$(use_enable introspection)
		$(use_enable caja)
		$(use_enable ps)
		$(use_enable t1lib)
		$(use_enable tiff)"
	DOCS="AUTHORS NEWS README TODO"
}

src_prepare() {
	# Fix .desktop categories, upstream bug #666346
	epatch "${FILESDIR}"/${PN}-1.2.1-desktop-categories.patch

	# Needed for linking when using gold
	#epatch "${FILESDIR}"/0001-Add-search-for-hypot.patch
	#epatch "${FILESDIR}"/0002-Add-gmodule-check-for-libdocument.patch

	mate_src_prepare
}
