# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit gnome2 python-single-r1 versionator

if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

#MATE_BRANCH="$(get_version_component_range 1-2)"

#SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Python bindings for the Caja file manager"
HOMEPAGE="http://www.mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="gtk3"

RDEPEND="dev-libs/glib:2
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	|| (
		>=mate-base/caja-1.8:0[introspection,gtk3?]
		>=mate-base/mate-file-manager-1.6:0[introspection,gtk3?]
	)
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	${PYTHON_DEPS}"

DEPEND="${RDEPEND}
	virtual/pkgconfig:*"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	if [[ ${PV} = 9999 ]]; then
		gnome2_src_configure --enable-gtk-doc
	else
		gnome2_src_configure
	fi
}

src_install() {
	gnome2_src_install

	# Keep the directory for systemwide extensions.
	keepdir /usr/share/python-caja/extensions/
}
