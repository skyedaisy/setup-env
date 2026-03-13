CONFIG_DIR="$HOME/.config/zsh"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

# load modular configs
for file in $CONFIG_DIR/*.zsh; do
  source "$file"
done