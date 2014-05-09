# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 

if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="A set of MATE themes, with sets for users with limited or low vision"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/gtk+-2:2
	>=x11-themes/gtk-engines-2.15.3:2
	x11-themes/murrine-themes"

DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	sys-devel/gettext"
# For problems related with dev-perl/XML-LibXML please see bug 266136

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README"

	gnome2_src_configure \
		--disable-test-themes \
		--enable-icon-mapping
}
