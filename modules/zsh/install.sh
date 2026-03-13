#!/usr/bin/env bash

echo "Installing Zsh ecosystem..."

ZSH_DIR="$HOME/.oh-my-zsh"
CUSTOM_DIR="$ZSH_DIR/custom"

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

# plugins
install_plugin () {
    name="$1"
    repo="$2"

    if [ ! -d "$CUSTOM_DIR/plugins/$name" ]; then
        echo "Installing plugin: $name"
        git clone "$repo" "$CUSTOM_DIR/plugins/$name"
    fi
}

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/catppuccin/zsh-fsh.git && cp zsh-fsh/themes/catppuccin-mocha.ini $HOME/.oh-my-zsh/plugins/fast-syntax-highlighting/themes && rm -rf zsh-fsh
# change default shell to zsh
if command -v zsh >/dev/null && [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi