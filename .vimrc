"curl" -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"exit"
"          .__
"    ___  _|__| ____________   ____
"    \  \/ /  |/     \_  __ \_/ ___\
"     \   /|  |  Y Y  \  | \/\  \___
"   /\ \_/ |__|__|_|  /__|    \___  >
"   \/              \/            \/
"
" https://github.com/kirjavascript/dotfiles
" Running this .vimrc as a shell script installs the required plugin manager

call plug#begin('~/.vim/plugged')

" tools
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'eugen0329/vim-esearch' " requires ag
" languages
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ternjs/tern_for_vim' , { 'do': 'npm install' }
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
" editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
" display
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/MatchTagAlways'
Plug 'terryma/vim-smooth-scroll'

call plug#end()

"" keymap

" unmap
map Q <Nop>

" move 'correctly' on wrapped lines
nnoremap j gj
nnoremap k gk

" remap cmd to semicolon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" EOL
nnoremap - $
vnoremap - $

" open word under cursor in mdn.io
function! Mdnio ()
  exec "!firefox http://mdn.io/".expand("<cword>")
endfunction
nnoremap K :silent call Mdnio ()<CR>

" easier split navigation
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" use alt + o/i for navigating buffers
execute "set <M-i>=\ei"
execute "set <M-o>=\eo"
nnoremap <M-i> :bp<CR>
nnoremap <M-o> :bn<CR>

" use alt + ./, for indenting
execute "set <M-,>=\e,"
execute "set <M-.>=\e."
nnoremap <M-.> >>
nnoremap <M-,> <<

" refresh
nnoremap <F5> :e! %<CR>

" redraw
nnoremap <F6> :redraw!<CR>

" word wrap
nnoremap <Leader>ww :set wrap!<CR>

" save files as sudo
nnoremap <Leader>su :w !sudo tee > /dev/null %<CR>

" edit .vimrc
nnoremap <Leader>rc :e $HOME/.vimrc<CR>

" edit .zshrc
nnoremap <Leader>zrc :e $HOME/.zshrc<CR>

" edit .i3/config
nnoremap <Leader>i3 :e $HOME/.i3/config<CR>

" edit todo
nnoremap <Leader>zx :e $HOME/todo<CR>

" load current file in firefox
nnoremap <Leader>fx :silent!firefox %<CR>

" reactify XML (eg react-native-svg)
nnoremap <Leader>rf :%s/\(<\/\?\)\(.\)/\1\U\2/g<CR>

" format PHP like it's HTML
nnoremap <Leader>fp :set ft=html<CR>gg=G<CR>:set ft=php<CR>

" hex helpers
nnoremap <Leader>hd :%! xxd<CR>
nnoremap <Leader>hf :%! xxd -r<CR>

" show weather report
nnoremap <silent> <Leader>we :! curl -s wttr.in/Manchester \| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"<CR>

"" plugin config

" esearch (maps <Leader>ff annoyingly)
let g:esearch = {
  \ 'adapter':    'ag',
  \ 'backend':    'system',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        [],
  \}

" snippets
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" bufexplorer
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" undotree
set undofile
nnoremap <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" mu-complete
set completeopt+=menuone,noinsert,noselect
set completeopt-=preview
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr> <cr> mucomplete#popup_exit("\<cr>")
set shortmess+=c " Shut off completion messages
call add(g:mucomplete#chains['default'], 'ulti') " work with ultisnips
" let g:mucomplete#enable_auto_at_startup = 1

" start NERDTree if no file is specified
nnoremap <Leader>nt :NERDTreeToggle<CR>
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd w | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 1)<CR>

" MatchTagAlways
let g:mta_filetypes = {'html':1,'xhtml':1,'xml':1,'php':1,'ejs':1}

" colourscheme
colo onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"" settings

set updatetime=250 " faster gitgutter
set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab " 4 space tabs
set rnu " relativenumber
set mouse=a " enable mouse support in terminal
set history=1000 " loadsa history
set hidden " switch buffers without saving
set fillchars+=vert:\│ " make split char a solid line
set backupcopy=yes " copy the file and overwrite the original
set clipboard=unnamedplus " set clipboard to system
set ttyfast " always assume a fast terminal
set ignorecase " case insensitive search
set smartcase " (unless uppercase chars are used)
set smartindent " adds one extra level in some cases
set go= " gvim: hide all ui stuff
set gfn=Hack\ 11 " gvim: set font to ttf-hack
set encoding=utf-8

let g:jsx_ext_required = 0 " enable JSX for .js files
runtime macros/matchit.vim " allow using % to navigate XML
au BufNewFile,BufRead *.ejs set filetype=html " load EJS files like HTML
au BufNewFile,BufRead *.asm set filetype=asm68k " specify m86k ASM
au FileType asm68k setlocal commentstring=;%s " comment string for m68k
au BufWritePre * %s/\s\+$//e " strip whitespace on saving
au BufWritePre * %s#\($\n\s*\)\+\%$##e " strip empty lines at end of file on saving
syntax keyword jsGlobalObjects d3 React $

" save swap, backup, etc to ~/.vim instead
for folder in ['backup', 'swap', 'undo']
    if !isdirectory($HOME.'/.vim/'.folder)
        call mkdir($HOME.'/.vim/'.folder, 'p')
    endif
endfor
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

" delete leftover swapfiles
call map(split(globpath('$HOME/.vim/swap', '*'), '\n'), 'delete(v:val)')

" osx overwrites
if has('macunix')
    set clipboard=unnamed
    set gfn=Hack\ Regular:h14 " font-hack
endif

" Use 24-bit (true-color) mode in Vim when outside tmux.
if (empty($TMUX))
  if (has('termguicolors'))
    set termguicolors
  endif
endif

" leave insert mode quickly in terminal
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
