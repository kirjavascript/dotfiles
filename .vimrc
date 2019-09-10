"           __
"    ___  _|__| ____________   ____
"    \  \/ /  |/     \_  __ \_/ ___\
"     \   /|  |  Y Y  \  | \/\  \___
"   /\ \_/ |__|__|_|  /__|    \___  >
"   \/              \/            \/

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" tools
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'mbbill/undotree'
Plug 'eugen0329/vim-esearch' " requires ripgrep
Plug 'dyng/ctrlsf.vim' " ???
" languages
Plug 'neoclide/vim-jsx-improve'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
" display
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/MatchTagAlways'
Plug 'xtal8/traces.vim'
Plug 'machakann/vim-highlightedyank'
" colours
Plug 'joshdick/onedark.vim'
Plug 'trevordmiller/nova-vim'
Plug 'kjssad/quantum.vim'

" Plug '~/dev/nibblrjr.vim'
" let g:nibblrjrURL = 'http://localhost:8888'

call plug#end()

"" keymap

" get original behaviour of a remapped key
nnoremap <F12> @=nr2char(getchar())<CR>

" unmap
map Q <Nop>

" make K do the opposite of J
nnoremap K :silent! s/^\(\s*\).*\%#\S\{-1,}\zs\s/\r\1<CR>==
vnoremap K :s/\s\+/\r/g<CR>gv=

" move 'correctly' on wrapped lines
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" remap cmd to semicolon
noremap ; :
noremap : ;

" easier split navigation
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" resizing splits
execute "set <M-h>=\eh"
execute "set <M-l>=\el"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
nnoremap <silent> <M-h> :vertical resize -5<CR>
nnoremap <silent> <M-l> :vertical resize +5<CR>
nnoremap <silent> <M-j> :resize +5<CR>
nnoremap <silent> <M-k> :resize -5<CR>

" use alt + o/i for navigating buffers
execute "set <M-i>=\ei"
execute "set <M-o>=\eo"
nnoremap <M-i> :bp<CR>
nnoremap <M-o> :bn<CR>
" osx
nnoremap “ :bp<CR>
nnoremap ‘ :bn<CR>

" refresh
nnoremap <F5> :e! %<CR>

" save files as sudo
nnoremap <Leader>su :w !sudo tee > /dev/null %<CR>

" open terminal from current directory
nnoremap <silent> <Leader>cf :term<CR>cd <C-W>"=expand('#:h:p')<CR><CR>clear<CR>

" close terminal
tnoremap <silent> <C-Q> exit<CR><C-W>:bd!<CR>

" edit .vimrc
nnoremap <Leader>rc :e $HOME/.vimrc<CR>

" edit .zshrc
nnoremap <Leader>zrc :e $HOME/.zshrc<CR>

" edit .i3/config
nnoremap <Leader>i3 :e $HOME/.i3/config<CR>

" edit todo
nnoremap <Leader>zx :e $HOME/todo<CR>

" load current file in firefox
nnoremap <Leader>fx :!firefox-nightly %<CR>

" reactify XML (eg react-native-svg)
nnoremap <Leader>rf :%s/\(<\/\?\)\(.\)/\1\U\2/g<CR>

" format PHP like it's HTML
nnoremap <Leader>fp :set ft=html<CR>gg=G<CR>:set ft=php<CR>

" hex helpers
nnoremap <Leader>hd :%! xxd<CR>
nnoremap <Leader>hf :%! xxd -r<CR>

" git blame
vnoremap <Leader>gb :<C-U>tabnew \|r!cd <C-R>=expand("%:p:h")<CR> && git annotate -L<C-R>=line("'<")<CR>,<C-R>=line("'>") <CR> <C-R>=expand("%:t") <CR><CR>

" paste to ix.io
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
vnoremap <Leader>sp :IX<CR>

" show weather report
nnoremap <silent> <Leader>we :! curl -s wttr.in/Manchester \| sed -r "s/\x1B\[[0-9;]*[JKmsu]//g"<CR>

"" plugin config

" esearch (maps <Leader>ff)
let g:esearch = {
  \ 'adapter':    'rg',
  \ 'backend':    'vim8',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        [],
  \ 'default_mappings': 1,
  \}

" CtrlSf
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

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
nnoremap <silent> <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" coc

" CocInstall coc-tsserver coc-eslint coc-html coc-json coc-css coc-stylelint coc-rls coc-phpls

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <leader>cg <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>crn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

set completeopt=menu,noinsert,noselect

" start NERDTree if no file is specified
nnoremap <Leader>nt :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd w | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeMapHelp = '<F1>'

" colourscheme / statusbar
colorscheme onedark
let g:lightline = {'colorscheme': 'one'}

if !has("gui_running")
    hi Normal guibg=NONE ctermbg=NONE
else
    let g:lightline.separator = {'left': '', 'right': ''}
    let g:lightline.subseparator = {'left': '', 'right': ''}
end
let g:lightline.active = {'left':[['mode','paste'],['gitbranch','readonly','filename','modified']]}
let g:lightline.component = {'lineinfo': '%3l:%-2v'}

" change colourscheme
noremap <silent> <leader>co :call LoadOneDark()<CR>
noremap <silent> <leader>cn :call LoadNova()<CR>

function! LoadNova()
    call lightline#disable()
    colorscheme nova
    let g:lightline.colorscheme = 'material'
    call lightline#init()
    call lightline#enable()
endfunction

function! LoadOneDark()
    call lightline#disable()
    colorscheme onedark
    let g:lightline.colorscheme = 'one'
    call lightline#init()
    call lightline#enable()
endfunction

" MatchTagAlways
let g:mta_filetypes = {'html':1,'xhtml':1,'xml':1,'php':1,'ejs':1}

" vim-highlighedyank
let g:highlightedyank_highlight_duration = 200

" disable polyglot stuff
let g:polyglot_disabled = ['javascript','jsx']

"" settings

set updatetime=250 " faster gitgutter
set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab " 4 space tabs
set relativenumber " relative line numbers
set mouse=a " enable mouse support in terminal
set laststatus=2 " always show a statusline
set noshowmode " hide -- INSERT -- text
set lazyredraw " don't redraw whenthere are pending macro operations
set history=1000 " loadsa history
set hidden " switch buffers without saving
set fillchars+=vert:\│ " make split char a solid line
set listchars+=space:• " show spaces with set list
set backupcopy=yes " copy the file and overwrite the original
set clipboard=unnamedplus " set clipboard to system
set ttyfast " always assume a fast terminal
set ignorecase " case insensitive search
set smartcase " (unless uppercase chars are used)
set incsearch " highlight when searching and map <C-g> / <C-t>
set wildmenu " cmd completion suggestions
set encoding=utf-8
set guioptions=c " gvim: hide all ui stuff
set guifont=Hack\ 11 " gvim: set font to ttf-hack

runtime macros/matchit.vim " allow using % to navigate XML
autocmd BufNewFile,BufRead *.ejs set filetype=html " load EJS files like HTML
autocmd BufNewFile,BufRead *.asm set filetype=asm68k " specify m86k ASM
autocmd FileType asm68k setlocal commentstring=;%s " comment string for m68k

" stripe whitespace on save
autocmd BufWritePre * call StripWhitespace()
function! StripWhitespace()
    if &ft == 'markdown'
        return
    endif
    let pos = getcurpos()
    %s/\s\+$//e " EOL
    %s#\($\n\s*\)\+\%$##e " EOF
    call setpos('.', pos)
endfunction

" save swap, backup, etc to ~/.vim instead
for folder in ['backup', 'swap', 'undo']
    if !isdirectory($HOME.'/.vim/'.folder)
        call mkdir($HOME.'/.vim/'.folder, 'p')
    endif
endfor
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//
set viminfo+=n$HOME/.vim/viminfo

" delete leftover swapfiles
call map(split(globpath('$HOME/.vim/swap', '*'), '\n'), 'delete(v:val)')

" osx overwrites
if has('macunix')
    set clipboard=unnamed
    set gfn=Hack\ Regular:h14 " font-hack
endif

" leave insert mode quickly in terminal
if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=0
    autocmd InsertLeave * set timeoutlen=1000
  augroup END
endif

" highlight otherwise unhighlighted files
autocmd BufRead,BufNewFile,BufWritePost * call HighlightGlobal()
function! HighlightGlobal()
  if &filetype == "" || &filetype == "text"
    syntax match txtNumber "\<\d\+\>"
    syntax match nonalphabet "[\<\>\=\!\/\:\\£\$\%€\^\&\*\(\)\[\]\?]"
    syntax match lineURL /\(https\?\|ftps\?\|git\|ssh\):\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
    highlight def link txtNumber Function
    highlight def link lineURL Number
    highlight def link nonalphabet Function
  endif
endfunction
