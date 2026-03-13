#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

stow_layer() {
    local layer="$1"
    local layer_dir="$DOTFILES_DIR/$layer"

    if [[ -d "$layer_dir" ]]; then
        echo "Applying $layer"
        stow -R -d "$layer_dir" -t "$HOME" .
    fi
}

echo "Applying dotfiles..."

# common
stow_layer common

# machine
case "${MACHINE:-unknown}" in
    wsl) stow_layer machines/wsl ;;
    vm) stow_layer machines/vm ;;
    baremetal) stow_layer machines/linux ;;
esac

# host roles
HOST_FILE="$HOME/.config/setup-env/host"

if [[ -f "$HOST_FILE" ]]; then
    while IFS= read -r role || [[ -n "$role" ]]; do

        [[ -z "$role" ]] && continue

        if [[ -d "$DOTFILES_DIR/hosts/$role" ]]; then
            echo "Applying host role: $role"
            stow_layer hosts/$role
        fi

    done < "$HOST_FILE"
fi

echo "Dotfiles applied."