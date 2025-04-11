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
alias nvim="$HOME/.local/share/neovim/bin/nvim" # No need on arch
alias vim="nvim"
alias v="nvim"

# TIC aliases
alias ll='ls --color=auto -l'
alias docker-compose='/usr/bin/docker compose'
alias dkc='UID_WORKER=$(id -u) GID_WORKER=$(id -g) /usr/bin/docker compose'
alias dkbuild='/usr/bin/docker compose down ; dkc build'
alias dkup='dkc up -d && /usr/bin/docker compose ps'
alias dkshow='/usr/bin/docker compose ps --all'
alias dklogs='/usr/bin/docker compose logs -t -f --tail=50'
alias dkexec='/usr/bin/docker compose exec'
alias dkwork='/usr/bin/docker compose exec workspace bash'
alias dkrun='/usr/bin/docker compose run --rm'

# Flutter
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH

# TIC - Pointage script
alias pointage="/home/mhommet/pointage/pointage"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# GO
export PATH=/usr/local/go/bin:$PATH

# FZF key bindings for ZSH
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Doom emacs
export PATH=$HOME/.config/emacs/bin:$PATH

# Starship prompt
eval "$(starship init zsh)" 
