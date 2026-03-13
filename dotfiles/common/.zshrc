source ~/.config/zsh/10-aliases.zsh
source ~/.config/zsh/20-theme.zsh
source ~/.config/zsh/30-env.zsh
source ~/.config/zsh/40-plugins.zsh

# machine specific
[ -f ~/.config/zsh/machine.zsh ] && source ~/.config/zsh/80-machine.zsh

# host specific
[ -f ~/.config/zsh/host.zsh ] && source ~/.config/zsh/90-host.zsh