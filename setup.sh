#!/bin/bash

# Vérifie si l'option --arch est présente
ARCH=false
if [[ "$1" == "--arch" ]]; then
    ARCH=true
fi

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# Liens de configuration principaux
for dir in doom fish nvim wezterm tmux ghostty; do
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

# Si l'option --arch est activée, configure polybar, rofi et i3
if $ARCH; then
    # Liens pour polybar
    POLYBAR_DIR=$CONFIG_DIR/polybar
    [ -e "$POLYBAR_DIR" ] && rm -rf "$POLYBAR_DIR"
    ln -s "$DOTFILES_DIR/polybar" "$POLYBAR_DIR"
    echo "Lien créé : $DOTFILES_DIR/polybar -> $POLYBAR_DIR"

    # Liens pour rofi
    ROFI_DIR=$CONFIG_DIR/rofi
    [ -e "$ROFI_DIR" ] && rm -rf "$ROFI_DIR"
    ln -s "$DOTFILES_DIR/rofi" "$ROFI_DIR"
    echo "Lien créé : $DOTFILES_DIR/rofi -> $ROFI_DIR"

    # Liens pour i3
    I3_DIR=$CONFIG_DIR/i3
    [ -e "$I3_DIR" ] && rm -rf "$I3_DIR"
    ln -s "$DOTFILES_DIR/i3" "$I3_DIR"
    echo "Lien créé : $DOTFILES_DIR/i3 -> $I3_DIR"
fi

