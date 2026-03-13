bootstrap_tools() {

    echo "Checking bootstrap tools..."
    if ! command -v curl &>/dev/null; then
        install_pkg curl
    fi
    if ! command -v git &>/dev/null; then
        install_pkg git
    fi
    if ! command -v yq &>/dev/null; then
        install_pkg yq
    fi
    if ! command -v chezmoi >/dev/null; then
    echo "[bootstrap] installing chezmoi"
    sh -c "$(curl -fsLS get.chezmoi.io)"
fi
}