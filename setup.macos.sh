#!/bin/bash

# Ensure Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi
# Update Homebrew
echo "Updating Homebrew..."
brew update
# Ensure zsh is installed
if ! brew list zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    brew install zsh
else
    echo "zsh is already installed."
fi

# Ensure oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh is already installed."
fi

brew install git tmux lf python@3.13 helix ffmpeg openssl@3 binwalk font-sauce-code-pro-nerd-font ngrok

if [ ! -d "$HOME/.config/helix" ]; then
    mkdir -p "$HOME/.config/helix"
fi
cp "$_DIR/config.toml" "$HOME/.config/helix/config.toml"

echo "Setting up zsh as the default shell..."
if ! grep -q "$(which zsh)" /etc/shells; then
    echo "$(which zsh)" | sudo tee -a /etc/shells
fi
chsh -s "$(which zsh)"
echo "Zsh has been set as the default shell."

rm -f "$HOME/.zshrc"
ln -s "$_DIR/zshrc" "$HOME/.zshrc"
echo "Symlinked .zshrc to $HOME/.zshrc"

rm -f "$HOME/.tmux.conf"
ln -s "$_DIR/tmux.conf" "$HOME/.tmux.conf"
echo "Symlinked .tmux.conf to $HOME/.tmux.conf"
