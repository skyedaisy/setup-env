#!/usr/bin/env bash

echo "Running test module"

MODULE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

packages=$(yq -r ".packages.$DISTRO[]" "$MODULE_DIR/module.yml")

install_pkg $packages