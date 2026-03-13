#!/usr/bin/env bash

set -euo pipefail

echo "Applying dotfiles..."

if ! command -v stow &>/dev/null; then
    echo "stow not installed"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

cd "$DOTFILES_DIR"

for dir in */; do
    [ -d "$dir" ] || continue

    echo "Stowing $dir"

    stow -R -t "$HOME" "$dir"
done

echo "Dotfiles applied."