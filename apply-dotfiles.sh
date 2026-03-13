#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

echo "[dotfiles] Applying dotfiles..."

apply_layer() {

    local layer="$1"
    local dir="$DOTFILES_DIR/$layer"

    if [[ -d "$dir" ]]; then
        echo "[dotfiles] layer: $layer"
        stow -R -d "$dir" -t "$HOME" .
    fi

}

# common config
apply_layer common

# machine config
case "${MACHINE:-unknown}" in
    wsl) apply_layer machines/wsl ;;
    vm) apply_layer machines/vm ;;
    baremetal) apply_layer machines/linux ;;
esac

# host config
HOST_FILE="$HOME/.config/setup-env/host"

if [[ -f "$HOST_FILE" ]]; then

    while read -r role; do

        [[ -z "$role" ]] && continue

        apply_layer "hosts/$role"

    done < "$HOST_FILE"

fi

echo "[dotfiles] Done"