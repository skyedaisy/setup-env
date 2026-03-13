#!/usr/bin/env bash

echo "Installing Zsh ecosystem..."

ZSH_DIR="$HOME/.oh-my-zsh"
CUSTOM_DIR="$ZSH_DIR/custom"

mkdir -p "$CUSTOM_DIR/plugins"
mkdir -p "$CUSTOM_DIR/themes"

# install oh-my-zsh
if [ ! -d "$ZSH_DIR" ]; then
    echo "Installing Oh My Zsh..."
    git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
fi

# install powerlevel10k
if [ ! -d "$CUSTOM_DIR/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git \
        "$CUSTOM_DIR/themes/powerlevel10k"
fi

install_plugin () {
    local name="$1"
    local repo="$2"

    if [ -d "$CUSTOM_DIR/plugins/$name/.git" ]; then
        git -C "$CUSTOM_DIR/plugins/$name" pull --quiet
    else
        echo "Installing plugin: $name"
        git clone --depth 1 "$repo" "$CUSTOM_DIR/plugins/$name"
    fi
}

install_plugin fast-syntax-highlighting \
https://github.com/zdharma-continuum/fast-syntax-highlighting

install_plugin zsh-autocomplete \
https://github.com/marlonrichert/zsh-autocomplete

install_plugin zsh-autosuggestions \
https://github.com/zsh-users/zsh-autosuggestions

# install catppuccin theme
THEME_FILE="$CUSTOM_DIR/plugins/fast-syntax-highlighting/themes/catppuccin-mocha.ini"

if [ ! -f "$THEME_FILE" ]; then
    TMP_DIR=$(mktemp -d)

    git clone --depth 1 https://github.com/catppuccin/zsh-fsh.git "$TMP_DIR"

    cp "$TMP_DIR/themes/catppuccin-mocha.ini" \
    "$CUSTOM_DIR/plugins/fast-syntax-highlighting/themes"

    rm -rf "$TMP_DIR"
fi

# change default shell
if command -v zsh >/dev/null; then
    ZSH_PATH="$(command -v zsh)"

    if [ "$SHELL" != "$ZSH_PATH" ]; then
        echo "Setting default shell to zsh..."
        chsh -s "$ZSH_PATH" || echo "Could not change shell automatically"
    fi
fi