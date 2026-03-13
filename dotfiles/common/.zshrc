CONFIG_DIR="$HOME/.config/zsh"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# load modular configs
for file in $CONFIG_DIR/*.zsh; do
  source "$file"
done