"=============================================================================
" stinger.vim -- set of custom initializations for SpaceVim
" Copy this file to ~/.SpaceVim/autoload directory
" Copyright (c) 2019 Andrew "Stinger" Abramov
" Author: Andrew "Stinger" Abramov stinger911 <at> gmail.com
"=============================================================================
function! stinger#Init ()
endfunction

function! stinger#set_maps() abort
    "call SpaceVim#custom#SPC('nore', ['g', 'b'], 'Gblame', 'view git blame', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'd'], 'Gdiff', 'view git diff', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'f'], 'Gina fetch', 'git fetch', 1)
    call SpaceVim#custom#SPC('nore', ['g', 'l'], 'Gina log', 'view git log', 1)
    " call SpaceVim#custom#SPC('nore', ['g', 'p'], ':Gpush', 'git push', 1)
    call SpaceVim#custom#SPC('nore', ['g', 's'], 'Gstatus', 'view git status', 1)

    " setup vimshell aliases 
    call vimshell#altercmd#define("ll", "ls -FGlAhp")
    "call vimshell#execute('cd() { builtin cd "$@"; ll; }')
    call vimshell#hook#add('chpwd', 'custom_chpwd', 'stinger#Chpwd')
endfunction

autocmd FileType vimshell
      \ call vimshell#altercmd#define("ll", "ls -FGlAhp")
      \| call vimshell#hook#add('chpwd', 'custom_chpwd', 'stinger#Chpwd')

function! stinger#Chpwd(args, context)
		call vimshell#execute('ls -FGlAhp')
endfunction
