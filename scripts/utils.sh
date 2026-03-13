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

apply_dotfiles() {

    local DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

    echo "[dotfiles] applying config"

    if ! command -v chezmoi >/dev/null 2>&1; then
        log "Installing chezmoi..."
        sh -c "$(curl -fsLS get.chezmoi.io)"
    fi

    chezmoi init --source "$DOTFILES_DIR"
    chezmoi apply
}