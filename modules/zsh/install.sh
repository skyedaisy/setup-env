#!/usr/bin/env bash

echo "Installing Zsh ecosystem..."

ZSH_DIR="$HOME/.oh-my-zsh"
CUSTOM_DIR="$ZSH_DIR/custom"

mkdir -p "$CUSTOM_DIR/plugins"
mkdir -p "$CUSTOM_DIR/themes"

# install oh-my-zsh
if [ ! -d "$ZSH_DIR" ]; then
    echo "Installing Oh My Zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
fi

# install powerlevel10k
if [ ! -d "$CUSTOM_DIR/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone https://github.com/romkatv/powerlevel10k.git \
        "$CUSTOM_DIR/themes/powerlevel10k"
fi

install_plugin () {
    name="$1"
    repo="$2"

    if [ ! -d "$CUSTOM_DIR/plugins/$name" ]; then
        echo "Installing plugin: $name"
        git clone "$repo" "$CUSTOM_DIR/plugins/$name"
    fi
}

install_plugin fast-syntax-highlighting \
https://github.com/zdharma-continuum/fast-syntax-highlighting

install_plugin zsh-autocomplete \
https://github.com/marlonrichert/zsh-autocomplete

install_plugin zsh-autosuggestions \
https://github.com/zsh-users/zsh-autosuggestions

# catppuccin theme
TMP_DIR=$(mktemp -d)
git clone https://github.com/catppuccin/zsh-fsh.git "$TMP_DIR"
cp "$TMP_DIR/themes/catppuccin-mocha.ini" \
"$CUSTOM_DIR/plugins/fast-syntax-highlighting/themes"
rm -rf "$TMP_DIR"

# change default shell
if command -v zsh >/dev/null && [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi