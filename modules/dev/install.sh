#!/usr/bin/env bash

MODULE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dev tools..."

packages=$(yq -r ".packages.$DISTRO[]" "$MODULE_DIR/module.yml")

install_pkg $packages