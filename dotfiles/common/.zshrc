# ~/.zshrc

# ---------------- core config ----------------
source ~/.config/zsh/config/env.zsh
source ~/.config/zsh/config/aliases.zsh
source ~/.config/zsh/config/plugins.zsh
source ~/.config/zsh/config/theme.zsh

# ---------------- machine layer ----------------
[ -f ~/.config/zsh/config/machine.zsh ] && source ~/.config/zsh/config/machine.zsh

# ---------------- host layer ----------------
[ -f ~/.config/zsh/config/host.zsh ] && source ~/.config/zsh/config/host.zsh