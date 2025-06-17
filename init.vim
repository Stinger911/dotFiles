call plug#begin('~/.config/nvim/plugged')
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'github/copilot.vim'
  Plug 'preservim/nerdtree'
  Plug 'gu-fan/simpleterm.vim'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/seoul256.vim'
  Plug 'sainnhe/sonokai'
  Plug 'menisadi/kanagawa.vim'
call plug#end()

PlugUpdate

silent! colorscheme kanagawa
set number
nmap <tab> :tabnext<CR>
nmap <c-tab> :tabprev<CR>
nmap <Space> <Leader>
nmap <Leader>f :NERDTreeToggle <CR>
nmap <Leader>bl :buffers<CR>
nmap <Leader>bn :bn<CR>
nmap <Leader>bp :bp<CR>
nmap <Leader>tn :tabnew<CR>
imap ]] <Esc>
imap ~~ <Esc>

" copied (almost) directly from the vim-lsp docs:
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> ld <plug>(lsp-definition)
    nmap <buffer> ls <plug>(lsp-document-symbol-search)
    nmap <buffer> lS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> lr <plug>(lsp-references)
    nmap <buffer> li <plug>(lsp-implementation)
    nmap <buffer> <Leader>lt <plug>(lsp-type-definition)
    nmap <buffer> <Leader>lrn <plug>(lsp-rename)
    nmap <buffer> [l <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]l <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.py,*.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    " is registered for a buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" show error information on statusline
let g:lsp_diagnostics_echo_cursor = get(g:, 'lsp_diagnostics_echo_cursor', 1)
let g:lsp_diagnostics_virtual_text_enabled = get(g:, 'lsp_diagnostics_virtual_text_enabled', 0)

