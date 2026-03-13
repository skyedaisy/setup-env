#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/bootstrap.sh"
source "$SCRIPT_DIR/lib/machine.sh"
source "$SCRIPT_DIR/lib/modules.sh"
source "$SCRIPT_DIR/lib/dispatcher.sh"

detect_package_manager
bootstrap_tools
detect_machine

load_modules

# ------------------------------
# CLI mode
# ------------------------------

if [ $# -gt 0 ]; then
    run_command "$@"
else

    get_host_role
    get_profile_from_host

    if [ -n "${PROFILE:-}" ]; then
        log "Using profile: $PROFILE"
        load_profile "$PROFILE"
    else
        run_installer
    fi

fi

# ------------------------------
# Post install
# ------------------------------

# ensure correct working directory
cd "$SCRIPT_DIR"

apply_dotfiles
apply_machine_tweaks