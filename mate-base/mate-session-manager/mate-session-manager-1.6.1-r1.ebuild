# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"

inherit mate

DESCRIPTION="MATE session manager"
HOMEPAGE="http://mate-desktop.org/"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="ipv6 elibc_FreeBSD systemd"

# x11-misc/xdg-user-dirs{,-gtk} are needed to create the various XDG_*_DIRs, and
# create .config/user-dirs.dirs which is read by glib to get G_USER_DIRECTORY_*
# xdg-user-dirs-update is run during login (see 10-user-dirs-update-gnome below).
RDEPEND=">=dev-libs/glib-2.16:2
	x11-libs/gtk+:2
	>=dev-libs/dbus-glib-0.76
	>=sys-power/upower-0.9.0
	elibc_FreeBSD? ( dev-libs/libexecinfo )

	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXtst
	x11-apps/xdpyinfo

	x11-misc/xdg-user-dirs
	x11-misc/xdg-user-dirs-gtk"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=sys-devel/gettext-0.10.40
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=mate-base/mate-common-1.2.2
	!<gnome-base/gdm-2.20.4
	systemd? ( sys-apps/systemd )"

src_prepare() {
	# Add "session saving" button back:
	# see https://bugzilla.gnome.org/show_bug.cgi?id=575544
	epatch "${FILESDIR}/${PN}-1.5.2-save-session-ui.patch"

	# Fix race condition in idle monitor, GNOME bug applies to MATE too,
	# see https://bugzilla.gnome.org/show_bug.cgi?id=627903
	epatch "${FILESDIR}/${PN}-1.2.0-idle-transition.patch"

	# Fix suspend support with systemd
	epatch "${FILESDIR}/${P}-login1.patch"

	# Use gnome-keyring
	epatch "${FILESDIR}/${PN}-1.6-gnome-keyring.patch"

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README"

	# TODO: convert libnotify to a configure option
	gnome2_src_configure \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--with-default-wm=mate-wm \
		--with-gtk=2.0 \
		$(use_enable ipv6) \
		$(use_with systemd)
}

src_install() {
	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}/MATE"

	dodir /usr/share/mate/applications/
	insinto /usr/share/mate/applications/
	doins "${FILESDIR}/defaults.list"

	dodir /etc/X11/xinit/xinitrc.d/
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}/15-xdg-data-mate"

	# This should be done in MATE too, see Gentoo bug #270852
	doexe "${FILESDIR}/10-user-dirs-update-mate"
}
