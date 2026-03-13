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
if [ "${1:-}" = "--list" ]; then
    list_modules
    exit 0
fi
if [ "${1:-}" = "--info" ]; then
    module_info "$2"
    exit 0
fi
run_installer "$@"

apply_machine_tweaks
apply_dotfiles