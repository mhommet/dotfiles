#!/bin/bash

# Global variables configuration
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# Creating symlinks for configurations
echo -e "\n🔗 Creating symlinks..."
for dir in fish nvim tmux; do
    TARGET=$CONFIG_DIR/$dir
    SOURCE=$DOTFILES_DIR/$dir

    [ -e "$TARGET" ] && rm -rf "$TARGET"
    ln -s "$SOURCE" "$TARGET"
    echo "🔗 Link created: $SOURCE -> $TARGET"
done

# Configuring starship
echo -e "\n🔗 Configuring starship..."
STARSHIP_CONFIG=~/.config/starship.toml
[ -e "$STARSHIP_CONFIG" ] && rm -f "$STARSHIP_CONFIG"
ln -s "$DOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG"
echo "🔗 Link created: $DOTFILES_DIR/starship.toml -> $STARSHIP_CONFIG"

echo -e "\n🎉 Installation completed successfully! 🚀"

