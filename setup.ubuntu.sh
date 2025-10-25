#!/bin/bash
_DIR=`cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd`

# Ensure zsh is installed
if ! zsh --version >/dev/null 2>&1; then
    echo "Installing zsh..."
    apt-get install zsh
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

sudo apt-get install git tmux python=3.13 helix ffmpeg openssl binwalk

if [ ! -d "$HOME/.config/helix" ]; then
    mkdir -p "$HOME/.config/helix"
fi
cp -f "$_DIR/config.toml" "$HOME/.config/helix/config.toml"

echo "Setting up zsh as the default shell..."
if ! grep -q "$(which zsh)" /etc/shells; then
    echo "$(which zsh)" | sudo tee -a /etc/shells
fi
if [ ! `echo $SHELL` = "/usr/bin/zsh" ]; then
    chsh -s "$(which zsh)"
    echo "Zsh has been set as the default shell."
fi

rm -f "$HOME/.zshrc"
ln -s "$_DIR/zshrc" "$HOME/.zshrc"
echo "Symlinked .zshrc to $HOME/.zshrc"

rm -f "$HOME/.tmux.conf"
ln -s "$_DIR/tmux.conf" "$HOME/.tmux.conf"
echo "Symlinked .tmux.conf to $HOME/.tmux.conf"

if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

echo 'export NVM_DIR="$HOME/.nvm"' >>~/.oh-my-zsh/oh-my-zsh.sh
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.oh-my-zsh/oh-my-zsh.sh
