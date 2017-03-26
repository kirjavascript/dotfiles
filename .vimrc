" Plugin manager; https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'

call plug#end()

let g:jsx_ext_required = 0 " enable JSX for .js files
set updatetime=250 " faster gitgutter
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " 4 space tabs
set rnu " relativenumber

au VimEnter * NERDTree

" colourscheme
syntax on
colo onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1

"Use 24-bit (true-color) mode in Vim when outside tmux.
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif
