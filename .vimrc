" Plugin manager; httpe://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

" tools
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'Valloric/YouCompleteMe' " , { 'do': './install.py --tern-completer' }
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
" languages
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
" editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'thirtythreeforty/lessspace.vim'
" display
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'

call plug#end()

set updatetime=250 " faster gitgutter
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab " 4 space tabs
set rnu " relativenumber
set mouse=a " enable mouse support in terminal
set history=1000 " loadsa history
set hidden " switch buffers without saving

let g:jsx_ext_required = 0 " enable JSX for .js files
au BufNewFile,BufRead *.ejs set filetype=html " load EJS files like HTML

" save swap, backup, etc to ~/.vim instead
for folder in ['backup', 'swap', 'undo']
    if !isdirectory($HOME.'/.vim/'.folder)
        call mkdir($HOME.'/.vim/'.folder, 'p')
    endif
endfor
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

" start NERDTree if no file is specified
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeStatusline = "(~˘▾˘)~"

" bufexplorer
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" undotree
set undofile
nnoremap <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
nnoremap <Leader>g :YcmCompleter GoTo<CR>

" set clipboard to system
set clipboard=unnamedplus

" colourscheme
colo onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Use 24-bit (true-color) mode in Vim when outside tmux.
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" gVim
set go=
set gfn=Hack\ 11 " ttf-hack

" osx overwrites
if has('macunix')
    set clipboard=unnamed
    set gfn=Hack\ Regular:h14 " font-hack
endif
