#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/bootstrap.sh"
source "$SCRIPT_DIR/lib/machine.sh"
source "$SCRIPT_DIR/lib/modules.sh"

detect_package_manager
bootstrap_tools
detect_machine
load_modules

run_installer "$@"

apply_machine_tweaks
apply_dotfiles