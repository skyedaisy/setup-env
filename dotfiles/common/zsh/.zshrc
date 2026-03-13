# common config
source ~/.config/zsh/config/aliases.zsh
source ~/.config/zsh/config/prompt.zsh
source ~/.config/zsh/config/env.zsh

# machine specific
if [ -f ~/.config/zsh/config/machine.zsh ]; then
    source ~/.config/zsh/config/machine.zsh
fi

# host specific
if [ -f ~/.config/zsh/config/host.zsh ]; then
    source ~/.config/zsh/config/host.zsh
fi