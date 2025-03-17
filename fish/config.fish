# Git
alias gst="git status"
alias gco="git checkout"
alias gtp="git push"
alias gpl="git pull"
alias gfc="git fetch"

# VIM
alias nvim="$HOME/.local/share/neovim/bin/nvim" # No need on arch
alias vim="nvim"
alias v="nvim"

# Alias TIC
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
set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -x PATH $JAVA_HOME/bin $PATH
set -x ANDROID_HOME /opt/android-sdk
set -x ANDROID_SDK_ROOT /opt/android-sdk
set -x PATH $ANDROID_HOME/platform-tools $PATH

# TIC - Pointage script
alias pointage="/home/mhommet/pointage/pointage"

starship init fish | source

# Remove default fish greeting
set fish_greeting

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# GO
set --export PATH /usr/local/go/bin $PATH
