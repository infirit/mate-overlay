# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
# Debug only changes CFLAGS
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit mate

DESCRIPTION="MATE default window manager"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gtk3 startup-notification test xinerama"

# Building against gtk+3 is broken.
# XXX: libgtop is automagic, hard-enabled instead
RDEPEND=" >=x11-libs/pango-1.2[X]
	
	gtk3? ( x11-libs/gtk+:3
			media-libs/libcanberra[gtk3] )
	!gtk3? ( x11-libs/gtk+:2
			media-libs/libcanberra[gtk] )
	>=dev-libs/glib-2.25.10:2
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libSM
	x11-libs/libICE
	gnome-base/libgtop
	>=mate-extra/mate-dialogs-1.2.0
	xinerama? ( x11-libs/libXinerama )
	!x11-misc/expocity
	!!x11-wm/mate-window-manager"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	test? ( app-text/docbook-xml-dtd:4.5 )
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/xextproto
	x11-proto/xproto"

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README *.txt doc/*.txt"

	G2CONF="${G2CONF}
		--enable-compositor
		--enable-render
		--enable-shape
		--enable-sm
		--enable-xsync
		$(use_enable startup-notification)
		$(use_enable xinerama)"
	
	use gtk3 && G2CONF="${G2CONF} --with-gtk=3.0"
	use !gtk3 && G2CONF="${G2CONF} --with-gtk=2.0"

	gnome2_src_configure
}
