#!/bin/bash

# Function to create a symlink only if the target does not already exist or is not a symlink
create_symlink() {
    if [ ! -L "$2" ]; then
        if [ ! -e "$2" ]; then
            ln -s "$1" "$2"
            echo "Symlink created for $2"
        else
            echo "File or directory exists but is not a symlink: $2"
        fi
    else
        echo "Symlink already exists for $2"
    fi
}

# Main symlinks in ~/.config
create_symlink ~/dotfiles/nvim ~/.config/nvim
create_symlink ~/dotfiles/starship.toml ~/.config/starship.toml
create_symlink ~/dotfiles/alacritty ~/.config/alacritty
create_symlink ~/dotfiles/fish ~/.config/fish
create_symlink ~/dotfiles/tmux ~/.config/tmux
create_symlink ~/dotfiles/doom ~/.config/doom
create_symlink ~/dotfiles/wezterm ~/.config/wezterm
create_symlink ~/dotfiles/alacritty ~/.config/alacritty

# Check for the --i3 option
if [[ "$1" == "--i3" ]]; then
    echo "Installing i3, rofi, and polybar configs"
    create_symlink ~/dotfiles/i3 ~/.config/i3
    create_symlink ~/dotfiles/polybar ~/.config/polybar
    create_symlink ~/dotfiles/rofi ~/.config/rofi
else
    echo "Skipping i3, rofi, and polybar configs"
fi

echo "Configuration installed"
