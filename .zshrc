bindkey '^R' history-incremental-search-backward

eval "$(starship init zsh)"

export EDITOR="nvim"
export N_PREFIX="$HOME/.local/n"
export K9S_CONFIG_DIR="$HOME/.config/k9s"

export PATH="/Users/firebain/.local/n/bin:$PATH"
export PATH="/Users/firebain/.duckdb/cli/latest:$PATH"
export PATH="~/go/bin:$PATH"

alias vim='nvim'
alias yarn="corepack yarn"
