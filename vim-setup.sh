#!/bin/sh
_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp $_DIR/init.vim ~/.vimrc

# neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
grep -vE "\"\\s+no_neovim" $_DIR/init.vim >~/.config/nvim/init.vim

