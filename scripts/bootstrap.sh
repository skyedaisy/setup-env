installing_utils() {

  echo "Checking utilities"
  if ! command -v curl &>/dev/null; then
    install_pkg curl
  fi
  if ! command -v git &>/dev/null; then
    install_pkg git
  fi
  if ! command -v yq &>/dev/null; then
    install_pkg yq
  fi
}
