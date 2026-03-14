run_command() {

    cmd="${1:-}"

    case "$cmd" in

    --list)
        list_modules
        exit 0
        ;;

    --info)
        if [[ -z "${2:-}" ]]; then
            echo "Usage: --info <module>"
            exit 1
        fi
        module_info "$2"
        exit 0
        ;;

    --profiles)
        list_profiles
        exit 0
        ;;

    --profile)
        load_profile "$2"
        apply_machine_tweaks
        apply_dotfiles
        exit 0
        ;;

    "")
        return
        ;;

    *)
        # treat as module name
        run_installer "$@"
        ;;

    esac
}
