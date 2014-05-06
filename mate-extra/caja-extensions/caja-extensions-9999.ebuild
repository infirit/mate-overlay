# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2 versionator

if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

#MATE_BRANCH="$(get_version_component_range 1-2)"

#SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Several Caja extensions"
HOMEPAGE="http://www.mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

SENDTO="cdr gajim +mail pidgin upnp"
IUSE="gtk3 image-converter +open-terminal share ${SENDTO}"

RDEPEND=">=dev-libs/glib-2.25.9:2
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( >=x11-libs/gtk+-2.18:2 )
	>=mate-base/caja-1.8.0[gtk3?]
	open-terminal? ( >=mate-base/mate-desktop-1.6.0[gtk3?] )
	cdr? ( >=app-cdr/brasero-2.32.1 )
	gajim? (
		net-im/gajim
		>=dev-libs/dbus-glib-0.60 )
	pidgin? ( >=dev-libs/dbus-glib-0.60 )
	upnp? ( >=net-libs/gupnp-0.13.0 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	>=mate-base/mate-common-1.2.2
	!!mate-extra/mate-file-manager-open-terminal
	!!mate-extra/mate-file-manager-sendto
	!!mate-extra/mate-file-manager-image-converter
	!!mate-extra/mate-file-manager-share"

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README"

	local myconf

	use gtk3 && myconf="${myconf} --with-gtk=3.0"
	use !gtk3 && myconf="${myconf} --with-gtk=2.0"

	if [[ ${PV} = 9999 ]]; then
		myconf="${myconf} --enable-gtk-doc"
	fi

	if use cdr || use mail || use pidgin || use gajim || use upnp; then
		myconf="${myconf} --enable-sendto"

		myconf="${myconf} --with-sendto-plugins=removable-devices"
		use cdr && myconf="${myconf},caja-burn"
		use mail && myconf="${myconf},emailclient"
		use pidgin && myconf="${myconf},pidgin"
		use gajim && myconf="${myconf},gajim"
		use upnp && myconf="${myconf},upnp"
	else
		myconf="${myconf} --disable-sendto"
	fi

	gnome2_src_configure \
		--disable-gksu \
		${myconf} \
		$(use_enable image-converter) \
		$(use_enable open-terminal) \
		$(use_enable share)
}
