call plug#begin('~/.config/nvim/plugged')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/seoul256.vim'
  Plug 'sainnhe/sonokai'
  Plug 'preservim/nerdtree'
call plug#end()

PlugUpdate

silent! colorscheme seoul256
nmap <tab> :tabnext<CR>
nmap <c-tab> :tabprev<CR>
nmap <Space>f :NERDTree<CR>
nmap <Space>bl :buffers<CR>
nmap <Space>bn :bn<CR>
nmap <Space>bp :bp<CR>
imap ]] <Esc>
imap ~~ <Esc>
