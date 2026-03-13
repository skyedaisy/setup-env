#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

apply_layer() {
    local layer="$1"

    if [ -d "$DOTFILES_DIR/$layer" ]; then
        echo "Applying $layer"
        stow -R \
            --dir "$DOTFILES_DIR/$layer" \
            --target "$HOME" \
            .
    fi
}

apply_layer common

case "${MACHINE:-unknown}" in
    wsl) apply_layer machines/wsl ;;
    vm) apply_layer machines/vm ;;
    baremetal) apply_layer machines/linux ;;
esac

HOST_FILE="$HOME/.config/setup-env/host"

if [ -f "$HOST_FILE" ]; then
    while read -r role; do
        [ -z "$role" ] && continue
        apply_layer "hosts/$role"
    done < "$HOST_FILE"
fi