#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/dispatcher.sh"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/bootstrap.sh"
source "$SCRIPT_DIR/lib/machine.sh"
source "$SCRIPT_DIR/lib/modules.sh"


detect_package_manager
bootstrap_tools
detect_machine

load_modules

# --------------------------------
# CLI commands
# --------------------------------

if [ $# -gt 0 ]; then
    run_command "$@"
    exit 0
fi

# --------------------------------
# Auto profile from host
# --------------------------------

get_host_role
get_profile_from_host

if [ -n "${PROFILE:-}" ]; then
    log "Using profile: $PROFILE"
    load_profile "$PROFILE"
else
    run_installer
fi

# --------------------------------
# Post install
# --------------------------------

apply_machine_tweaks
apply_dotfiles