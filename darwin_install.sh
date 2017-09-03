#!/usr/bin/env bash
xcode-select --install

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew bundle

defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
