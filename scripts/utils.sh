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
get_host_role() {

    HOST_FILE="$HOME/.config/setup-env/host"

    # jika sudah ada jangan overwrite
    if [ -f "$HOST_FILE" ]; then
        echo "Host role already configured:"
        cat "$HOST_FILE"
        return
    fi

    echo ""
    echo "Select host role:"
    echo ""

    options=("home" "server" "pentest" "lab" "custom")

    select opt in "${options[@]}"; do

        case $opt in

            home|server|pentest|lab)

                ROLE="$opt"
                break
                ;;

            custom)

                read -rp "Enter custom role: " ROLE
                break
                ;;

            *)

                echo "Invalid option"
                ;;

        esac

    done

    mkdir -p "$(dirname "$HOST_FILE")"

    echo "$ROLE" > "$HOST_FILE"

    echo "Host role set to: $ROLE"
}

get_profile_from_host() {

    HOST_FILE="$HOME/.config/setup-env/host"

    if [ ! -f "$HOST_FILE" ]; then
        return
    fi

    ROLE=$(head -n1 "$HOST_FILE")

    case "$ROLE" in
        home)
            PROFILE="base"
            ;;
        pentest)
            PROFILE="pentest"
            ;;
        server)
            PROFILE="server"
            ;;
        dev)
            PROFILE="dev"
            ;;
        *)
            PROFILE=""
            ;;
    esac

}

list_profiles() {

    echo "Available profiles:"
    echo

    for file in "$SCRIPT_DIR"/profiles/*.yml; do
        basename "$file" .yml
    done

}
backup_if_exists() {

    local file="$1"

    if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        log "Backing up $file"
        mv "$HOME/$file" "$HOME/$file.backup"
    fi
}
apply_dotfiles() {

    log "Applying dotfiles with stow..."

    if ! command -v stow >/dev/null 2>&1; then
        log "Installing stow..."
        pkg_install stow
    fi

    local DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

    # --------------------------
    # common layer
    # --------------------------

    if [ -d "$DOTFILES_DIR/common" ]; then
        log "Applying common dotfiles"
        backup_if_exists ".bashrc"
        backup_if_exists ".zshrc"
        stow -R -d "$DOTFILES_DIR" -t "$HOME" common
    fi


    # machine layer
    if [[ -n "${MACHINE:-}" ]]; then
        if [[ -d "$DOTFILES_DIR/machines/$MACHINE" ]]; then
            log "Applying machine: $MACHINE"
            log "MACHINE=$MACHINE"
            stow -nvt -d "$DOTFILES_DIR/machines" -t "$HOME" "$MACHINE"
        fi
    fi

    # profile layer
    if [[ -n "${PROFILE:-}" ]]; then
        if [[ -d "$DOTFILES_DIR/profiles/$PROFILE" ]]; then
            log "Applying profile: $PROFILE"
            stow -nvt -d "$DOTFILES_DIR/profiles" -t "$HOME" "$PROFILE"
        fi
    fi
}

