# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
#-----------------------------zsh------------------------------------#
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY
export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nano'
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_COLORIZE_TOOL=chroma
ZSH_COLORIZE_STYLE="colorful"
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256
#-----------------------------zsh------------------------------------#

#-----------------------------env------------------------------------#
export GOPATH=$HOME/go
export PATH="$HOME/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/bin:$PATH"
#-----------------------------env------------------------------------#

# -------------------------------- plugin ----------------------------#
plugins=(
  zsh-interactive-cd
  fast-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh



# -------------------------------- plugin ----------------------------#

# -------------------------------- aliases ----------------------------#
alias ls=" ls --color -sh"
alias nmap="grc nmap"
alias netstat="grc netstat"
alias ping="grc ping"
alias tail="grc tail"
alias ps="grc ps"
alias services="systemctl list-units --type=service"
# -------------------------------- aliases ----------------------------#

# -------------------------------- api ----------------------------#

# -------------------------------- api ----------------------------#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

