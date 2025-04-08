#!/bin/bash

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# Lien pour starship.toml
STARSHIP_CONFIG=~/.config/starship.toml
[ -e "$STARSHIP_CONFIG" ] && rm -f "$STARSHIP_CONFIG"
ln -s "$DOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG"
echo "Lien créé : $DOTFILES_DIR/starship.toml -> $STARSHIP_CONFIG"

# Lien pour .zshrc
ZSHRC=~/.zshrc
[ -e "$ZSHRC" ] && rm -f "$ZSHRC"
ln -s "$DOTFILES_DIR/.zshrc" "$ZSHRC"
echo "Lien créé : $DOTFILES_DIR/.zshrc -> $ZSHRC"

# Configuration du thème Warp
WARP_THEMES_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes
mkdir -p "$WARP_THEMES_DIR"
echo "Dossier de thèmes Warp créé : $WARP_THEMES_DIR"

# Copie du thème personnalisé
cp "$DOTFILES_DIR/One_Dark.yaml" "$WARP_THEMES_DIR/One_Dark.yaml"
echo "Thème copié : $DOTFILES_DIR/One_Dark.yaml -> $WARP_THEMES_DIR/One_Dark.yaml"
echo "Le thème sera disponible après redémarrage de Warp ou après quelques minutes." 
