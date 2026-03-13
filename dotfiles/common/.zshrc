export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh


# --------------------------
# Load common configs
# --------------------------

for file in ~/.config/zsh/[0-9]*.zsh; do
    source "$file"
done


# --------------------------
# Load machine config
# --------------------------

if [[ -n "$SETUP_ENV_MACHINE" ]]; then
    MACHINE_FILE="$HOME/.config/zsh/machine-$SETUP_ENV_MACHINE.zsh"

    if [[ -f "$MACHINE_FILE" ]]; then
        source "$MACHINE_FILE"
    fi
fi


# --------------------------
# Load host config
# --------------------------

if [[ -f "$HOME/.config/setup-env/host" ]]; then
    while read -r role; do

        [[ -z "$role" ]] && continue

        HOST_FILE="$HOME/.config/zsh/host-$role.zsh"

        if [[ -f "$HOST_FILE" ]]; then
            source "$HOST_FILE"
        fi

    done < "$HOME/.config/setup-env/host"
fi