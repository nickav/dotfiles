#!/usr/bin/env bash
xcode-select --install

# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew bundle

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# apple config
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# normal scrolling
defaults write -g com.apple.swipescrolldirection -bool NO
defaults write com.apple.dock launchanim -bool false
defaults write NSGlobalDomain KeyRepeat -int 0
# opening and closing windows and popovers
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
# showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
defaults write -g NSWindowResizeTime -float 0.001
# opening and closing Quick Look windows
defaults write -g QLPanelAnimationDuration -float 0
# rubberband scrolling (doesn't affect web views)
defaults write -g NSScrollViewRubberbanding -bool false
# resizing windows before and after showing the version browser
# also disabled by NSWindowResizeTime -float 0.001
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
# showing a toolbar or menu bar in full screen
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
# scrolling column views
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
# showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
# showing and hiding Mission Control, command+numbers
defaults write com.apple.dock expose-animation-duration -float 0
# showing and hiding Launchpad
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
# changing pages in Launchpad
defaults write com.apple.dock springboard-page-duration -float 0
# at least AnimateInfoPanes
defaults write com.apple.finder DisableAllAnimations -bool true
# hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# apply config changes
killall Finder
killall Dock
