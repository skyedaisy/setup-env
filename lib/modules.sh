#!/usr/bin/env bash

MODULES=()
INSTALLED_MODULES=()

load_modules() {

    for dir in "$SCRIPT_DIR/modules/"*; do
        name=$(basename "$dir")
        MODULES+=("$name")
    done
}

run_module() {

    local module="$1"
    local module_dir="$SCRIPT_DIR/modules/$module"
    local module_yaml="$module_dir/module.yml"
    local module_script="$module_dir/install.sh"

    if [[ " ${INSTALLED_MODULES[*]} " =~ " $module " ]]; then
        return
    fi

    deps=$(yq -r '.dependencies[]?' "$module_yaml")

    for dep in $deps; do
        run_module "$dep"
    done

    log "Installing module: $module"

    source "$module_script"

    INSTALLED_MODULES+=("$module")
}

run_cli() {

    for module in "$@"; do
        run_module "$module"
    done
}

run_interactive() {

    PS3="Select module: "
    options=("${MODULES[@]}" "all" "exit")

    select opt in "${options[@]}"
    do
        case $opt in

            all)
                for module in "${MODULES[@]}"; do
                    run_module "$module"
                done
                ;;

            exit)
                break
                ;;

            *)
                run_module "$opt"
                ;;
        esac
    done
}

run_installer() {

    if [ $# -gt 0 ]; then
        run_cli "$@"
    else
        run_interactive
    fi
}