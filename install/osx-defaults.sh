# !/usr/bin/env zsh"

echo "  ›  Close any open System Preferences panes, to prevent them from overriding settings we’re about to change"
osascript -e 'tell application "System Preferences" to quit'

echo "  ›  Ask for the administrator password upfront"
sudo -v

echo "  ›  Keep-alive: update existing 'sudo' time stamp until '.osx' has finished"
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo "  ›  Set computer name (as done via System Preferences → Sharing)"
sudo scutil --set ComputerName "oriol"
sudo scutil --set HostName "oriol"
sudo scutil --set LocalHostName "oriol"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "oriol"

sudo /usr/sbin/systemsetup -settimezone "Europe/Madrid"
sudo /usr/sbin/systemsetup -setnetworktimeserver "time.euro.apple.com"
sudo /usr/sbin/systemsetup -setusingnetworktime on

echo "  ›  Locale"
defaults write NSGlobalDomain AppleLocale -string "es_ES"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

echo "  ›  24-Hour Time"
defaults write NSGlobalDomain AppleICUForce12HourTime -bool false

echo "  ›  Set standby delay to 2 hours (default is 1 hour) - in seconds"
sudo pmset -a standbydelay 7200

echo "  ›  Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo "  ›  Show battery life percentage."
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  ›  Disable the new window animation - every new window grows from a small one to a big one over a few hundred millisecs"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "  ›  Disable animations when opening a Quick Look window."
defaults write -g QLPanelAnimationDuration -float 0

echo "  ›  Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "  ›  Disable guests to login to this computer"
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

echo "  ›  Shake mouse cursor to locate"
defaults write CGDisableCursorLocationMagnification -bool false

echo "  ›  Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  ›  Allow applications downloaded from anywhere"
sudo spctl --master-disable

echo "  ›  Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "  ›  Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "  ›  Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  ›  Don't relaunch open apps on restart"
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

echo "  ›  Disable sound effects when changing volume"
defaults write NSGlobalDomain com.apple.sound.beep.feedback -integer 0

echo "  ›  Disable sounds effects for user interface changes"
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

echo "  ›  Allow fast user switching (icon style, in the menu bar)"
defaults write NSGlobalDomain userMenuExtraStyle -int 2

echo "  ›  Menu bar clock format"
echo "  ›  "h:mm" Default"
echo "  ›  "HH"   Use a 24-hour clock"
echo "  ›  "a"    Show AM/PM"
echo "  ›  "ss"   Display the time with seconds"
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm:ss"

echo "  › Set dark interface style"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo "  › Set graphite appearance"
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

echo "  › Set graphite highlight color"
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

echo "  ›  Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "  ›  Trackpad: map bottom right corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

echo "  ›  Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "  ›  Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "  ›  Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "  ›  Set keyboard repeat rate to "damn fast"."
defaults write NSGlobalDomain KeyRepeat -int 2

echo "  ›  Set a shorter delay until key repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "  ›  Disable annoying "application crashed" dialogs"
defaults write com.apple.CrashReporter DialogType none

echo "  › Set up trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

###############################################################################
# Finder                                                                      #
###############################################################################

echo "  ›  New Finder windows points to home"
defaults write com.apple.finder NewWindowTarget -string "PfHm"

echo "  ›  Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "  ›  Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  ›  Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  ›  Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  ›  Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  ›  Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "  ›  When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "  ›  Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  ›  Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "  ›  Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo "  ›  Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "  ›  Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "  ›  Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "  ›  Show item info near icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

echo "  ›  Enable sort by kind for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist

echo "  ›  Use icon view in all Finder windows by default Four-letter codes for the view modes: 'icnv', 'clmv', 'Flwv', 'Nlsv'"
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

echo "  ›  Allow text-selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "  ›  Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "  ›  Show the ~/Library folder"
chflags nohidden ~/Library

echo "  ›  Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "  ›  Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "  › Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "  › Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
echo "  ›  Possible values: 'WhenScrolling', 'Automatic' and 'Always'"

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

###############################################################################
# SSD"
###############################################################################

echo "  ›  Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

echo "  ›  Set the icon size of Dock items to 16 pixels"
defaults write com.apple.dock tilesize -int 16

echo "  ›  Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "  ›  Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "  ›  Dashboard: 1: Off, 2: As Space, 3: As Overlay"
defaults write com.apple.dashboard enabled-state -int 1

echo "  ›  Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "  ›  Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0
echo "  ›  Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

echo "  ›  Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "  ›  Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

echo "  ›  Wipe all (default) app icons from the Dock"
defaults write com.apple.dock persistent-apps -array

echo "  ›  Disables osx choose accents popup"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  ›  Hide indicator lights for open applications"
defaults write com.apple.dock show-process-indicators -bool false

echo "  ›  Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "  ›  Disables hot top left screen corner"
defaults write com.apple.dock wvous-tl-corner -int 0
echo "  ›  Disables hot top right screen corner"
defaults write com.apple.dock wvous-tr-corner -int 0
echo "  ›  Disables hot bottom left screen corner"
defaults write com.apple.dock wvous-bl-corner -int 0
echo "  ›  Disables hot bottom right screen corner"
defaults write com.apple.dock wvous-br-corner -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo "  ›  Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "  ›  Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

echo "  ›  Show the full URL in the address bar (note: this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "  ›  New windows open with: Empty Page"
defaults write com.apple.Safari NewWindowBehavior -int 1

echo "  ›  New tabs open with: Empty Page"
defaults write com.apple.Safari NewTabBehavior -int 1

echo "  ›  Set Safari’s home page to 'about:blank' for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "  ›  Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "  ›  Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "  ›  Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "  ›  Remove useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "  ›  Hide Safari’s sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "  ›  Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "  ›  Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "  ›  Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "  ›  Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

echo "  ›  Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

echo "  ›  Enable “Do Not Track”"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "  › Disable the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

###############################################################################
# Mail                                                                        #
###############################################################################

echo "  ›  Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

echo "  ›  Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "  ›  Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

echo "  ›  Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo "  ›  Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

echo "  ›  Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

echo "  ›  Use a modified version of the Dracula theme by default in Terminal.app"
osascript <<EOD
tell application "Terminal"
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Dracula"
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window
	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$HOME/.dotfiles/term-preferences/dracula-terminal/" & themeName & ".terminal'"
	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName
	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window
	repeat with windowID in allOpenedWindows
		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)
		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if
	end repeat
end tell
EOD

echo "  ›  Enable Secure Keyboard Entry in Terminal.app"
echo "  ›  See: https://security.stackexchange.com/a/47786/8918"
defaults write com.apple.terminal SecureKeyboardEntry -bool true

echo "  ›  Don’t display the annoying prompt when quitting iTerm2"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

echo "  ›  Specify the preferences directory of iTerm2"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles"

echo "  ›  Tell iTerm2 to use the custom preferences in the directory"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

###############################################################################
# Time Machine                                                                #
###############################################################################

echo "  ›  Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "  ›  Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disable local

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "  ›  Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo "  ›  Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo "  ›  Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "  ›  Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit and QuicTimePlayer                                                 #
###############################################################################

echo "  ›  Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

echo "  ›  Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

echo "  ›  Auto-play videos when opened with QuickTime Player"
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

echo "  ›  Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

echo "  ›  Disable automatic emoji substitution (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

echo "  ›  Disable smart quotes as it’s annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "  ›  Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Contacts (Address Book)                                                     #
###############################################################################

echo "  ›  Sort by last name"
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

###############################################################################
# Archive Utility                                                             #
###############################################################################

echo "  ›  Move archives to trash after extraction"
defaults write com.apple.archiveutility "dearchive-move-after" -string "~/.Trash"

echo "  ›  Don't reveal extracted items"
defaults write com.apple.archiveutility "dearchive-reveal-after" -bool false

###############################################################################
# Transmission.app                                                            #
###############################################################################

echo "  ›  Use '~/Documents/Torrents' to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

echo "  ›  Use '~/Downloads' to store completed downloads"
defaults write org.m0k.transmission DownloadLocationConstant -bool true

echo "  ›  Don’t prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

echo "  ›  Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "  ›  Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false
echo "  ›  Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

echo "  ›  IP block list."
echo "  ›  Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/"
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

echo "  ›  Randomize port on launch"
defaults write org.m0k.transmission RandomPort -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"Terminal" \
	"Transmission" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

