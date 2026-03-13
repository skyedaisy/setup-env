#!/usr/bin/env bash
shopt -s nullglob
MODULES=()
INSTALLED_MODULES=()

load_modules() {

    for dir in "$SCRIPT_DIR/modules/"*; do
        [ -d "$dir" ] || continue

        name=$(basename "$dir")
        MODULES+=("$name")
    done
}
list_modules() {

    echo ""
    echo "Available modules:"
    echo ""

    for dir in "$SCRIPT_DIR/modules/"*; do

        [ -d "$dir" ] || continue

        yaml="$dir/module.yml"

        name=$(yq -r '.name' "$yaml")
        desc=$(yq -r '.description // "No description"' "$yaml")
        deps=$(yq -r '.dependencies[]?' "$yaml" | tr '\n' ' ')

        printf "%-12s %s\n" "$name" "$desc"

        if [ -n "$deps" ]; then
            echo "             deps: $deps"
        fi

        echo ""

    done
}
load_profile() {

    profile="$1"
    profile_file="$SCRIPT_DIR/profiles/$profile.yml"

    if [ ! -f "$profile_file" ]; then
        echo "Profile not found: $profile"
        exit 1
    fi

    modules=$(yq '.modules[]' "$profile_file")

    for module in $modules; do
        run_module "$module"
    done

}
module_info() {

    module="$1"

    yaml="$SCRIPT_DIR/modules/$module/module.yml"

    if [ ! -f "$yaml" ]; then
        echo "Module not found"
        exit 1
    fi

    echo ""
    echo "Module: $(yq -r '.name' "$yaml")"
    echo ""

    echo "Description:"
    yq -r '.description' "$yaml"
    echo ""

    echo "Dependencies:"
    yq -r '.dependencies[]?' "$yaml"
    echo ""

    echo "Packages for $DISTRO:"
    yq -r ".packages.$DISTRO[]" "$yaml"
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
                if [[ " ${MODULES[*]} " =~ " $opt " ]]; then
                    run_module "$opt"
                else
                    echo "Invalid option"
                fi
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