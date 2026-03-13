# history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

export TERM=xterm-256color
export EDITOR=nano

# paths
export GOPATH=$HOME/go
export PATH="$HOME/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/bin:$PATH"