#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]] ; then
	echo "Skip as it is not running on macos" 1>&2
	exit 0
fi

# Install xcode
if [ "$(xcode-select -p > /dev/null && echo 'installed')" == '' ]; then
	xcode-select --install > /dev/null
fi

# Install homebrew
if [ "$(which brew > /dev/null && echo 'installed')" == '' ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
fi
