"=============================================================================
" stinger.vim -- set of custom initializations for SpaceVim
" Copy this file to ~/.SpaceVim/autoload directory
" Copyright (c) 2019 Andrew "Stinger" Abramov
" Author: Andrew "Stinger" Abramov stinger911 <at> gmail.com
"=============================================================================
function! stinger#Init ()
endfunction

function! stinger#set_maps() abort
    "nmap <Space>gb  :Gblame<CR>
    "nmap <Space>gd  :Gdiff<CR>
    "nmap <Space>gf  :Gfetch<CR>
    "nmap <Space>gl  :Glog<CR>
    "nmap <Space>gp  :Gpush<CR>
    "nmap <Space>gs  :Gstatus<CR>

    call SpaceVim#custom#SPC('nore', ['g', 'b'], 'Gblame', 'view git blame', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'd'], 'Gdiff', 'view git diff', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'f'], 'Gina fetch', 'git fetch', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'l'], 'Glog', 'view git log', 1)
    " call SpaceVim#custom#SPC('nore', ['g', 'p'], ':Gpush', 'git push', 1)
    call SpaceVim#custom#SPC('nore', ['g', 's'], 'Gstatus', 'view git status', 1)
endfunction
