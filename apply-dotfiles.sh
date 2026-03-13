#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

cd "$DOTFILES_DIR"

stow_layer() {

    local layer="$1"

    if [ -d "$layer" ]; then
        echo "Applying $layer"
        stow -R -t "$HOME" "$layer"
    fi
}

echo "Applying dotfiles..."

# --------------------
# common config
# --------------------

stow_layer common

# --------------------
# machine layer
# --------------------

case "${MACHINE:-unknown}" in
    wsl)
        stow_layer machines/wsl
        ;;
    vm)
        stow_layer machines/vm
        ;;
    baremetal)
        stow_layer machines/linux
        ;;
esac

# --------------------
# host roles
# --------------------

HOST_FILE="$HOME/.config/setup-env/host"

if [ -f "$HOST_FILE" ]; then
    shopt -s nullglob
    while read -r role; do

        [ -z "$role" ] && continue

        if [ -d "hosts/$role" ]; then
            echo "Machine: $MACHINE"
            echo "Applying host role: $role"
            stow_layer "hosts/$role"
        fi

    done < "$HOST_FILE"

fi

echo "Dotfiles applied."