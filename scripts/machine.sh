#!/usr/bin/env bash

detect_machine() {

    if grep -qi microsoft /proc/sys/kernel/osrelease; then
        MACHINE="wsl"

    elif command -v systemd-detect-virt &>/dev/null; then

        VIRT=$(systemd-detect-virt)

        if [ "$VIRT" != "none" ]; then
            MACHINE="vm"
        else
            MACHINE="baremetal"
        fi

    else
        MACHINE="unknown"
    fi

    log "Machine type: $MACHINE"
}

apply_machine_tweaks() {

    if [ "$MACHINE" = "wsl" ]; then
        source "$SCRIPT_DIR/machines/wsl.sh"
    fi
}