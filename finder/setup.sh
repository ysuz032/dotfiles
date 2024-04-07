#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]] ; then
	echo "Skip as it is not running on macos" 1>&2
	exit 0
fi

NEED_RESTART='false'

# Show files with all extensions
if [ "$(defaults read NSGlobalDomain AppleShowAllExtensions)" != '1' ]; then
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	NEED_RESTART='true'
fi

# Display the path bar
if [ "$(defaults read com.apple.finder ShowPathbar)" != '1' ]; then
	defaults write com.apple.finder ShowPathbar -bool true
	NEED_RESTART='true'
fi

# ********************
# 
# apply all settings
# 
# ********************
if [ "${NEED_RESTART}" == 'true' ]; then
	killall "Finder" &> /dev/null
fi
