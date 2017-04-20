" Plugin manager; https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Valloric/YouCompleteMe' " , { 'do': './install.py --tern-compiler' }
Plug 'terryma/vim-multiple-cursors'

call plug#end()

let g:jsx_ext_required = 0 " enable JSX for .js files
set updatetime=250 " faster gitgutter
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " 4 space tabs
set rnu " relativenumber

" load EJS files like HTML
au BufNewFile,BufRead *.ejs set filetype=html

" start NERDTree if no file is specified
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = "(~˘▾˘)~"

" turn off YouCompleteMe preview
set completeopt = menu

" use system clipboard as default buffer
set clipboard = unnamedplug

" colourscheme
colo onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"Use 24-bit (true-color) mode in Vim when outside tmux.
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" gVim
set go=
set gfn=Hack\ 11 " use ttf-hack
