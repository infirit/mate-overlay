# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GCONF_DEBUG="no"

if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

#MATE_BRANCH="$(get_version_component_range 1-2)"

#SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A set of backgrounds packaged with the MATE desktop"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-util/intltool-0.35:*
	sys-devel/gettext:*"

DOCS="AUTHORS ChangeLog NEWS README"
