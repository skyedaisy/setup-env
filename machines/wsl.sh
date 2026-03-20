#!/usr/bin/env bash

echo "Applying WSL specific configuration..."

# WSL biasanya tidak pakai systemd
echo "Skipping systemctl operations"

# contoh config WSL
mkdir -p ~/.config

# contoh: disable docker service enable
echo "WSL detected, skipping service enable"

echo "WSL configuration done."