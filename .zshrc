path+=~/go/bin

eval "$(starship init zsh)"
# export PATH="/usr/local/opt/node@22/bin:$PATH"
export PATH="/Users/firebain/.local/n/bin:$PATH"
export PATH='/Users/firebain/.duckdb/cli/latest':$PATH
export EDITOR="nvim"
export N_PREFIX="$HOME/.local/n"

bindkey '^R' history-incremental-search-backward

alias vim='NVIM_APPNAME="nvim" nvim'
alias myvim='NVIM_APPNAME="mynvim" nvim'
alias lvim='NVIM_APPNAME="lnvim" nvim'

alias yarn="corepack yarn"
