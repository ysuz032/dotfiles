#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]] ; then
	echo "Skip as it is not running on macos" 1>&2
	exit 0
fi

if [ "$(which brew > /dev/null && echo 'installed')" == '' ]; then
	echo "homebrew is not installed." 1>&2
	exit 1
fi

if [ ! -e "${HOME}/.Brewfile" ]; then
	echo "${HOME}/.Brewfile is not found" 1>&2
	exit 1
fi

brew bundle --global
