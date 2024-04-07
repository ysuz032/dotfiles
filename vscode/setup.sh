#!/bin/bash

set -euo pipefail

THIS_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SETTING_DIR="${HOME}/Library/Application Support/Code/User"

# Link settings.json
ln -snfv "${THIS_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
