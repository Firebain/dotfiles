bindkey '^R' history-incremental-search-backward
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

eval "$(starship init zsh)"

export EDITOR="nvim"
export N_PREFIX="$HOME/.local/n"
export K9S_CONFIG_DIR="$HOME/.config/k9s"

export PATH="$HOME/.local/n/bin:$PATH"
export PATH="$HOME/.duckdb/cli/latest:$PATH"
export PATH="$HOME/go/bin:$PATH"

alias vim='nvim'
export PATH="$HOME/.local/bin:$PATH"
