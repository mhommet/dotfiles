#!/bin/bash

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# Liens de configuration principaux
for dir in kitty fish nvim tmux; do
    TARGET=$CONFIG_DIR/$dir
    SOURCE=$DOTFILES_DIR/$dir

    # Supprime le lien ou dossier existant
    [ -e "$TARGET" ] && rm -rf "$TARGET"

    # Crée le lien symbolique
    ln -s "$SOURCE" "$TARGET"
    echo "Lien créé : $SOURCE -> $TARGET"
done

# Lien pour starship.toml (fichier à part)
STARSHIP_CONFIG=~/.config/starship.toml
[ -e "$STARSHIP_CONFIG" ] && rm -f "$STARSHIP_CONFIG"
ln -s "$DOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG"
echo "Lien créé : $DOTFILES_DIR/starship.toml -> $STARSHIP_CONFIG"

