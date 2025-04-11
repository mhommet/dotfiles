#!/bin/bash

# Configuration des variables globales
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
TOTAL_STEPS=10
CURRENT_STEP=0

# Fonction pour détecter la distribution
detect_distro() {
    if [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# Fonction pour installer un paquet selon la distribution
install_package() {
    local package=$1
    case $(detect_distro) in
        "debian")
            sudo apt update && sudo apt install -y "$package"
            ;;
        "arch")
            sudo pacman -Syu --noconfirm "$package"
            ;;
    esac
}

# Fonction pour afficher la progression
progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    printf "\r[%-50s] %d%%" "$(printf '#%.0s' $(seq 1 $((PERCENT/2))))" "$PERCENT"
}

# Fonction pour vérifier si une commande existe
command_exists() {
    command -v "$1" &> /dev/null
}

echo "🚀 Démarrage de l'installation des dotfiles..."
progress

# Installation des outils de base
echo -e "\n📦 Installation des outils de base..."

# Installation de tmux
if ! command_exists tmux; then
    echo "🚧 Installation de tmux..."
    install_package tmux
else
    echo "✅ tmux est déjà installé"
fi
progress

# Installation des dépendances de développement
echo -e "\n🔧 Installation des outils de développement..."
case $(detect_distro) in
    "debian")
        install_package gcc
        install_package make
        install_package ripgrep
        ;;
    "arch")
        install_package "base-devel ripgrep"
        ;;
esac
progress

# Installation de rustup pour la gestion des versions de Neovim
if ! command_exists rustup; then
    echo "🚧 Installation de rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
else
    echo "✅ rustup est déjà installé"
fi
progress

# Installation de bob pour la gestion des versions de Neovim
if ! command_exists bob; then
    echo "🚧 Installation de bob..."
    cargo install bob-nvim
    bob use latest
else
    echo "✅ bob est déjà installé"
fi
progress

# Installation de kitty
if ! command_exists kitty; then
    echo "🚧 Installation de kitty..."
    install_package kitty
else
    echo "✅ kitty est déjà installé"
fi
progress

# Installation de fish
if ! command_exists fish; then
    echo "🚧 Installation de fish..."
    install_package fish
else
    echo "✅ fish est déjà installé"
fi
progress

# Création des liens symboliques pour les configurations
echo -e "\n🔗 Création des liens symboliques..."
for dir in kitty fish nvim tmux doom; do
    TARGET=$CONFIG_DIR/$dir
    SOURCE=$DOTFILES_DIR/$dir

    [ -e "$TARGET" ] && rm -rf "$TARGET"
    ln -s "$SOURCE" "$TARGET"
    echo "🔗 Lien créé : $SOURCE -> $TARGET"
done
progress

# Installation de starship
echo -e "\n✨ Installation de starship..."
if ! command_exists starship; then
    echo "🚧 Installation de starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "✅ starship est déjà installé"
fi
progress

# Configuration de starship
echo -e "\n🔗 Configuration de starship..."
STARSHIP_CONFIG=~/.config/starship.toml
[ -e "$STARSHIP_CONFIG" ] && rm -f "$STARSHIP_CONFIG"
ln -s "$DOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG"
echo "🔗 Lien créé : $DOTFILES_DIR/starship.toml -> $STARSHIP_CONFIG"
progress

echo -e "\n🎉 Installation terminée avec succès ! 🚀"

