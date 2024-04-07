#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]] ; then
	echo "Skip as it is not running on macos" 1>&2
	exit 0
fi

# Use a custom theme
# Use a Iceberg theme by default in Terminal.app
THIS_DIR="$(cd "$(dirname "$0")" && pwd)"
TERM_PROFILE='Iceberg';
CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
    open "${THIS_DIR}/${TERM_PROFILE}.terminal"
    defaults write com.apple.Terminal "Default Window Settings" -string "${TERM_PROFILE}"
    defaults write com.apple.Terminal "Startup Window Settings" -string "${TERM_PROFILE}"
fi
defaults import com.apple.Terminal "${HOME}/Library/Preferences/com.apple.Terminal.plist"
