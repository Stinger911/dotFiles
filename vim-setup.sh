#!/bin/sh
_DIR=$( cd -- "$( dirname -- "${0}" )" &> /dev/null && pwd )

if [ ! -e ~/.vim/autoload/plug.vim ]; then
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp $_DIR/init.vim ~/.vimrc

# neovim
if [ ! -e ~/.local/share/nvim/site/autoload/plug.vim ]; then
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

mkdir -p ~/.config/nvim
grep -vE "\"\\s+no_neovim" $_DIR/init.vim >~/.config/nvim/init.vim

