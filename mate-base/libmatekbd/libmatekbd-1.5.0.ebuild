# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"
MATE_LA_PUNT="yes"

inherit mate

DESCRIPTION="MATE keyboard configuration library"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

# gtk+-2.20 needed for tests
RDEPEND=">=dev-libs/glib-2.18:2
	x11-libs/gtk+:2
	>=x11-libs/libxklavier-5.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable test tests)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

#src_prepare() {

	# Require -lm because we use sqrt,atan and sincos -- fixed dd 2013-02-04
	#epatch "${FILESDIR}"/0001-libmatekbd-Require-lm-when-using-sqrt.patch

	# Fix underlinking and building with glib 2.32 -- fixed dd 2013-02-04
	# epatch "${FILESDIR}"/0002-Fix-building-with-glib-2.32.patch

	# Unneeded casts removed
	# epatch "${FILESDIR}/${P}-unneeded-casts.patch"

	# Remove GDK_DISPLAY() usage
	# epatch "${FILESDIR}/${P}-gdkdisplay-usage.patch"

	# Replace GDK_keyname with GDK_KEY_keyname
	# epatch "${FILESDIR}/${P}-gdkkeyname-replace.patch"

#	mate_src_prepare
#}
