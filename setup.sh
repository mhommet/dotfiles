#!/bin/bash

# Global variables configuration
DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
TOTAL_STEPS=10
CURRENT_STEP=0

# Function to detect distribution
detect_distro() {
    if [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# Function to install a package according to the distribution
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

# Function to display progress
progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    printf "\r[%-50s] %d%%" "$(printf '#%.0s' $(seq 1 $((PERCENT/2))))" "$PERCENT"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

echo "🚀 Starting dotfiles installation..."
progress

# Installing basic tools
echo -e "\n📦 Installing basic tools..."

# Installing tmux
if ! command_exists tmux; then
    echo "🚧 Installing tmux..."
    install_package tmux
else
    echo "✅ tmux is already installed"
fi
progress

# Installing development dependencies
echo -e "\n🔧 Installing development tools..."
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

# Installing rustup for Neovim version management
if ! command_exists rustup; then
    echo "🚧 Installing rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
else
    echo "✅ rustup is already installed"
fi
progress

# Installing bob for Neovim version management
if ! command_exists bob; then
    echo "🚧 Installing bob..."
    cargo install bob-nvim
    bob use latest
else
    echo "✅ bob is already installed"
fi
progress

# Installing wezterm
if ! command_exists wezterm; then
    echo "🚧 Installing wezterm..."
    case $(detect_distro) in
        "debian")
            # Wezterm is not in Debian default repositories, using GitHub
            echo "📥 Downloading wezterm from GitHub..."
            TEMP_DEB=$(mktemp)
            curl -L -o "$TEMP_DEB" "https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Debian11.deb"
            sudo apt install -y "$TEMP_DEB"
            rm "$TEMP_DEB"
            ;;
        "arch")
            # Using pacman for Arch
            install_package wezterm
            ;;
    esac
else
    echo "✅ wezterm is already installed"
fi
progress

# Installing fish
if ! command_exists fish; then
    echo "🚧 Installing fish..."
    install_package fish
else
    echo "✅ fish is already installed"
fi
progress

# Creating symlinks for configurations
echo -e "\n🔗 Creating symlinks..."
for dir in wezterm fish nvim tmux doom; do
    TARGET=$CONFIG_DIR/$dir
    SOURCE=$DOTFILES_DIR/$dir

    [ -e "$TARGET" ] && rm -rf "$TARGET"
    ln -s "$SOURCE" "$TARGET"
    echo "🔗 Link created: $SOURCE -> $TARGET"
done
progress

# Installing starship
echo -e "\n✨ Installing starship..."
if ! command_exists starship; then
    echo "🚧 Installing starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "✅ starship is already installed"
fi
progress

# Configuring starship
echo -e "\n🔗 Configuring starship..."
STARSHIP_CONFIG=~/.config/starship.toml
[ -e "$STARSHIP_CONFIG" ] && rm -f "$STARSHIP_CONFIG"
ln -s "$DOTFILES_DIR/starship.toml" "$STARSHIP_CONFIG"
echo "🔗 Link created: $DOTFILES_DIR/starship.toml -> $STARSHIP_CONFIG"
progress

echo -e "\n🎉 Installation completed successfully! 🚀"

