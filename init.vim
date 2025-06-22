call plug#begin('~/.config/nvim/plugged')
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'github/copilot.vim'  " no_neovim
  Plug 'preservim/nerdtree'
  Plug 'gu-fan/simpleterm.vim'  " no_neovim
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}  " no_neovim
  Plug 'junegunn/fzf.vim'  " no_neovim
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/seoul256.vim'
  Plug 'sainnhe/sonokai'
  Plug 'menisadi/kanagawa.vim'
call plug#end()

" Function to check and run PlugUpdate once per day
function! CheckAndRunPlugUpdate()
    let l:last_update_file = expand('~/.config/nvim/last_plug_update')

    " Check if the file exists
    if filereadable(l:last_update_file)
        " Get the last update time from the file
        let l:last_update_time = readfile(l:last_update_file)[0]
    else
        " If the file doesn't exist, initialize the time to 0
        let l:last_update_time = 0
    endif

    " Get the current time in seconds since epoch
    let l:current_time = localtime()

    " Check if 24 hours have passed since the last update
    if l:current_time - l:last_update_time > 24 * 60 * 60
        " Run PlugUpdate
        PlugUpdate

        " Update the last update time in the file
        call writefile([l:current_time], l:last_update_file)
    endif
endfunction

" Call the function during Vim startup
call CheckAndRunPlugUpdate()

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
nmap <Leader>q :qa<CR>
nmap <Leader>w :wa<CR>
nmap <Leader>Q :qa!<CR>
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

