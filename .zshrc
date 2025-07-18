# Basic ZSH Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Git aliases
alias gst="git status"
alias gco="git checkout"
alias gtp="git push"
alias gpl="git pull"
alias gfc="git fetch"

# VIM aliases
alias nvim="$HOME/neovim/bin/nvim" # MACOS
alias vim="nvim"
alias v="nvim"

# Starship prompt
eval "$(starship init zsh)" 
