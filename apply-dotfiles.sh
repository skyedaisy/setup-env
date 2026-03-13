#!/usr/bin/env bash

set -euo pipefail

echo "Applying dotfiles..."
if ! command -v stow &>/dev/null; then
    echo "stow not installed"
    exit 1
fi
DOTFILES_DIR="$(dirname "$0")/dotfiles"

cd "$DOTFILES_DIR"

for dir in */; do
    dir=${dir%/}
    echo "Stowing $dir"
    stow "$dir"
done

echo "Dotfiles applied."