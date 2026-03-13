export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ----------------
# core config
# ----------------

for file in ~/.config/zsh/*.zsh; do
    source "$file"
done