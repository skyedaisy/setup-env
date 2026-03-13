#!/usr/bin/env bash

# -----------------------------------------
# simple logging helper
# -----------------------------------------
log() {
    echo "[setup-env] $*"
}

# -----------------------------------------
# detect package manager and load wrapper
# -----------------------------------------
detect_package_manager() {

    log "Detecting package manager..."

    if command -v pacman &>/dev/null; then
        DISTRO="arch"
        source "$SCRIPT_DIR/pkg/pacman.sh"

    elif command -v apt &>/dev/null; then
        DISTRO="ubuntu"
        source "$SCRIPT_DIR/pkg/apt.sh"

    else
        echo "Unsupported distro"
        exit 1
    fi
}

# -----------------------------------------
# apply dotfiles using stow
# -----------------------------------------
apply_dotfiles() {

    log "Applying dotfiles..."

    if ! command -v stow &>/dev/null; then
        echo "stow not installed"
        exit 1
    fi

    DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

    cd "$DOTFILES_DIR"

    for dir in */ ; do
        [ -d "$dir" ] || continue
        stow "$dir"
    done
}