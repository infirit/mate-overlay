# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"
WANT_AUTOMAKE="1.9"

inherit mate

DESCRIPTION="The MATE Terminal"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

	# libgnome needed for some monospace font schema, bug #274638
	# Remove gtk3 useflag because it doesn't build
RDEPEND=">=dev-libs/glib-2.25.12:2
	x11-libs/gtk+:2
	>=x11-libs/vte-0.26.0:0
	x11-libs/libSM
	>=mate-base/libmate-1.2.0"

DEPEND="${RDEPEND}
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/mate-doc-utils-1.2.1
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog HACKING NEWS README"
