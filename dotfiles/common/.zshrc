CONFIG_DIR="$HOME/.config/zsh"

for file in "$CONFIG_DIR"/*.zsh(N); do
    source "$file"
done