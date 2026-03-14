#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"
source "$SCRIPT_DIR/scripts/bootstrap.sh"
source "$SCRIPT_DIR/scripts/machine.sh"
source "$SCRIPT_DIR/scripts/modules.sh"
source "$SCRIPT_DIR/scripts/dispatcher.sh"
log "Starting setup-env..."
detect_package_manager
bootstrap_tools
detect_machine
load_modules
CLI_MODE=false
if [[ $# -gt 0 ]]; then
  CLI_MODE=true
  run_command "$@"
else
  get_host_role
  get_profile_from_host
  if [[ -n ${PROFILE:-} ]]; then
    log "Using profile: $PROFILE"
    load_profile "$PROFILE"
  else
    run_installer
  fi
fi
if [[ $CLI_MODE == false ]]; then
  log "Applying dotfiles..."
  apply_dotfiles
  log "Applying machine tweaks..."
  apply_machine_tweaks
fi
log "Setup complete."
