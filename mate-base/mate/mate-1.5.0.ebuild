# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Meta ebuild for MATE, The traditional desktop environment"
HOMEPAGE="http://mate-desktop.org"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="bluetooth +extras"

RDEPEND=">=mate-base/libmatekeyring-1.5.0
	>=mate-base/mate-keyring-1.5.0
	>=x11-libs/libmatenotify-1.5.0
	>=mate-base/libmatekbd-1.5.0
	>=dev-libs/libmateweather-1.5.0
	>=x11-themes/mate-icon-theme-1.5.0
	>=mate-extra/mate-dialogs-1.5.0
	>=mate-base/mate-desktop-1.5.0
	>=mate-base/mate-file-manager-1.5.0
	>=x11-themes/mate-backgrounds-1.5.0
	>=mate-base/mate-menus-1.5.0
	>=x11-wm/mate-window-manager-1.5.0
	>=mate-extra/mate-polkit-1.5.0
	>=mate-base/mate-settings-daemon-1.5.0
	>=mate-base/mate-control-center-1.5.0
	>=mate-base/mate-panel-1.5.0
	>=mate-base/mate-session-manager-1.5.0
	>=x11-themes/mate-themes-1.5.0
	>=mate-extra/mate-utils-1.5.0
	>=mate-extra/mate-media-1.5.0
	>=mate-extra/mate-screensaver-1.5.0
	>=x11-misc/mate-menu-editor-1.5.0
	>=x11-terms/mate-terminal-1.4.0
	virtual/notification-daemon
	extras? (
		>=mate-extra/mate-power-manager-1.5.0
		>=app-editors/mate-text-editor-1.5.0
		>=app-arch/mate-file-archiver-1.5.0
		>=media-gfx/mate-image-viewer-1.5.0
		>=app-text/mate-document-viewer-1.5.0
		>=mate-extra/mate-system-monitor-1.5.0
		>=mate-extra/mate-calc-1.5.0
	)
	bluetooth? ( >=net-wireless/mate-bluetooth-1.5.0 )"

pkg_postinst() {
	elog "If you found a bug and have a solution, contact joost_op in #sabayon-dev at freenode.net."
}
