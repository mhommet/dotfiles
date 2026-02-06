# Git
alias gst="git status"
alias gco="git checkout"
alias gtp="git push"
alias gpl="git pull"
alias gfc="git fetch"

# VIM
#alias nvim="$HOME/nvim/bin/nvim" # MACOS
alias nvim="$HOME/nvim.appimage"
alias vim="nvim"
alias v="nvim"
alias python="python3"

starship init fish | source

# Remove default fish greeting
set fish_greeting

fish_add_path -m ~/.local/bin

set -gx HSA_OVERRIDE_GFX_VERSION 12.0.0
set -gx HSA_ENABLE_SDMA 1
set -gx PATH /opt/rocm/bin $PATH

# LiteLLM Proxy (fix 404)
set -gx ANTHROPIC_AUTH_TOKEN ollama
set -gx ANTHROPIC_BASE_URL http://localhost:4000/v1  # LiteLLM !
set -gx ANTHROPIC_API_KEY ""

# Pipx PATH
set PATH $PATH /home/milan/.local/bin
fish_config theme choose "Catppuccin Mocha"
