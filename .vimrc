"           __
"    ___  _|__| ____________   ____
"    \  \/ /  |/     \_  __ \_/ ___\
"     \   /|  |  Y Y  \  | \/\  \___
"   /\ \_/ |__|__|_|  /__|    \___  >
"   \/              \/            \/

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! source ~/.vim/env.vim " load ANTHROPIC_API_KEY

call has('python3') " force py3

" disable polyglot stuff
let g:polyglot_disabled = ['javascript','jsx']

call plug#begin('~/.vim/plugged')

" tools
Plug 'kirjavascript/nibblrjr.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jlanzarotta/bufexplorer'
Plug 'mbbill/undotree'
Plug 'eugen0329/vim-esearch' " requires ripgrep
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' } " requires ripgrep
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'lambdalisue/suda.vim'
" languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/vim-jsx-improve'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/asmM68k.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" editing
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
" display
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'xtal8/traces.vim'
Plug 'machakann/vim-highlightedyank'
" colours
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'fcpg/vim-orbital'
" avante.vim
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

call plug#end()

"" keymap

" get original behaviour of a remapped key
nnoremap <F12> @=nr2char(getchar())<CR>

" unmap
map Q <Nop>
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

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
if !has('nvim')
    execute "set <A-h>=\eh"
    execute "set <A-l>=\el"
    execute "set <A-j>=\ej"
    execute "set <A-k>=\ek"
endif
nnoremap <silent> <A-h> :vertical resize -5<CR>
nnoremap <silent> <A-l> :vertical resize +5<CR>
nnoremap <silent> <A-j> :resize +5<CR>
nnoremap <silent> <A-k> :resize -5<CR>

" use alt + o/i for navigating buffers
if !has('nvim')
    execute "set <A-i>=\ei"
    execute "set <A-o>=\eo"
endif
nnoremap <A-i> :bp<CR>
nnoremap <A-o> :bn<CR>
" osx
nnoremap “ :bp<CR>
nnoremap ‘ :bn<CR>

" refresh
nnoremap <F5> :e! %<CR>

" save files as sudo
if has('nvim')
    nnoremap <Leader>su :w suda://%<CR>
else
    nnoremap <Leader>su :w !sudo tee > /dev/null %<CR>
endif

" open terminal from current directory
nnoremap <silent> <Leader>t :term<CR>cd <C-W>"=expand('#:h:p')<CR><CR>clear<CR>

" close terminal
tnoremap <silent> <C-Q> exit<CR><C-W>:bd!<CR>

" edit .vimrc
nnoremap <Leader>rc :e $HOME/.vimrc<CR>

" edit .zshrc
nnoremap <Leader>zrc :e $HOME/.zshrc<CR>

" edit .i3/config
nnoremap <Leader>i3 :e $HOME/.config/i3/config<CR>

" edit todo
nnoremap <Leader>zx :e $HOME/todo<CR>

" load current file in firefox
nnoremap <Leader>fx :!firefox %<CR>

" reactify XML (eg react-native-svg)
nnoremap <Leader>rf :%s/\(<\/\?\)\(.\)/\1\U\2/g<CR>

" format PHP like it's HTML
nnoremap <Leader>fp :set ft=html<CR>gg=G<CR>:set ft=php<CR>

" hex helpers
nnoremap <Leader>hd :%! xxd<CR>
nnoremap <Leader>hf :%! xxd -r<CR>

" git blame
vnoremap <Leader>gb :<C-U>tabnew \|r!cd <C-R>=expand("%:p:h")<CR> && git annotate -L<C-R>=line("'<")<CR>,<C-R>=line("'>") <CR> <C-R>=expand("%:t") <CR><CR>

" ix.io
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard

" pasta
command! -range Pasta call s:Pasta(<line1>,<line2>)
function! s:Pasta(line1, line2)
    let l:code = join(getline(a:line1, a:line2), "\n")
    let l:url = system('curl -s --data-binary @- https://pasta.cx', l:code)
    let l:ext = expand('%:e')
    if len(l:ext) != 0
        let l:url = l:url . '.' . l:ext
    endif
    call system('xclip -i -selection clipboard', l:url)
    echo l:url
endfunction
vnoremap <Leader>sp :Pasta<CR>

"" plugin config

let g:session_autosave = 'no'

" esearch (maps <Leader>ff)
let g:esearch = {
  \ 'adapter':    'rg',
  \ 'backend':    has('nvim') ? 'nvim' : 'vim8',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        [],
  \ 'default_mappings': 1,
  \}

" CtrlSf
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_auto_focus = { 'at': 'start' }

" fzf
function! RootDir()
    return trim(system('cd ' . expand('%:h') . ' && git rev-parse --show-toplevel 2> /dev/null'))
endfunction
function! FZF()
    call fzf#vim#files(RootDir())
endfunction
nnoremap <Leader>fz :call FZF()<CR>

" bufexplorer
nnoremap <silent> <Leader>b :BufExplorer<CR>
let g:bufExplorerDisableDefaultKeyMapping=1

" undotree
set undofile
nnoremap <silent> <Leader>u :UndotreeToggle <BAR> :UndotreeFocus<CR>

" coc

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-json', 'coc-css', 'coc-stylelint', 'coc-rust-analyzer', 'coc-phpls', 'coc-vimlsp', 'coc-clangd', 'coc-lua']

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <leader>cg <Plug>(coc-definition)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>cr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>crn <Plug>(coc-rename)
vmap <leader>cf  <Plug>(coc-format-selected)
nnoremap <leader>cf :call CocAction('format')<CR>
" coc plugin config
command! -nargs=0 Prettier :CocCommand prettier.formatFile

nnoremap <silent> <leader>cd :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

set completeopt=menu,noinsert,noselect

" start NERDTree if no file is specified
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
" autocmd StdinReadPre * let s:std_in=1
" let s:hasnofile = argc() == 0 && !exists('s:std_in')
" autocmd VimEnter * if s:hasnofile | NERDTree | wincmd w | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeMapHelp = '<F1>'
let g:NERDTreeDirArrowExpandable='►' " set explicitly to force working in neovide
let g:NERDTreeDirArrowCollapsible='▼'

" colourscheme / statusbar
if has('nvim')
    let g:neovide_transparency=0.9
    colorscheme neodark
    highlight! Normal guibg=NONE ctermbg=NONE
    highlight! Cursor ctermfg=1 ctermbg=1 guibg=steelblue
    let g:lightline = {'colorscheme': 'orbital'}
else
    colorscheme onedark
    let g:lightline = {'colorscheme': 'one'}
endif

if !has('gui_running') && !has('nvim')
    highlight! Normal guibg=NONE ctermbg=NONE
else
    let g:lightline.separator = {'left': '', 'right': ''}
    let g:lightline.subseparator = {'left': '', 'right': ''}
end
let g:lightline.active = {'left':[['mode','paste'],['gitbranch','readonly','filename','modified']]}
let g:lightline.component = {'lineinfo': '%3l:%-2v'}

" change colourscheme
noremap <silent> <leader>co :call SetTheme('onedark', 'one')<CR>
noremap <silent> <leader>cb :call SetTheme('orbital', 'orbital')<CR>
noremap <silent> <leader>cp :call SetTheme('neodark', 'orbital')<CR>

function! SetTheme(main, bar)
    call lightline#disable()
    execute 'colorscheme ' . a:main
    let g:lightline.colorscheme = a:bar
    call lightline#init()
    call lightline#enable()
endfunction

" vim-highlighedyank
let g:highlightedyank_highlight_duration = 200

"" settings

set updatetime=250 " faster gitgutter
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab " 4 space tabs
set relativenumber " relative line numbers
set mouse=a " enable mouse support in terminal
set mousemodel=extend " disable right click menu
set shortmess=I " hide startup message
set laststatus=2 " always show a statusline
set noshowmode " hide -- INSERT -- text
set lazyredraw " don't redraw whenthere are pending macro operations
set history=1000 " loadsa history
set hidden " switch buffers without saving
set fillchars+=vert:\│ " make split char a solid line
set listchars+=space:• " show spaces with set list
set listchars+=eol:$ " show NL with $
set listchars+=tab:<-> " show tab as <->
set backupcopy=yes " copy the file and overwrite the original
set clipboard=unnamedplus " set clipboard to system
set ttyfast " always assume a fast terminal
set ignorecase " case insensitive search
set smartcase " (unless uppercase chars are used)
set incsearch " highlight when searching and map <C-g> / <C-t>
set nohlsearch " dont highlight everything
set wildmenu " cmd completion suggestions
set encoding=utf-8
set title " show filepath in UI title
set guioptions=c " gvim: hide all ui stuff
set guifont=Fira\ Code:h11 " tty-fira-code
runtime macros/matchit.vim " allow using % to navigate XML

augroup Config
    autocmd!
    autocmd BufWritePost *vimrc source ~/.vimrc " autoreload vimrc
    autocmd BufNewFile,BufRead *.ejs set filetype=html " load EJS files like HTML
    autocmd BufNewFile,BufRead *.asm,*.s set filetype=asm68k " specify m86k ASM
    autocmd FileType asm68k setlocal commentstring=;%s " comment string for m68k
    " autocmd bufnewfile,bufread *.js set filetype=javascript.jsx " enable JSX
    " autocmd bufnewfile,bufread *.ts set filetype=typescript.tsx " enable JSX for TS
    autocmd BufWritePre * call StripWhitespace()
    autocmd BufRead,BufNewFile,BufWritePost * call HighlightGlobal()
augroup END

" stripe whitespace on save
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
if has('nvim')
    set viminfo+=n$HOME/.vim/nviminfo
else
    set viminfo+=n$HOME/.vim/viminfo
endif

" delete leftover swapfiles on startup
autocmd VimEnter * call map(split(globpath('$HOME/.vim/swap', '*'), '\n'), 'delete(v:val)')

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

" avante

if has('nvim')
lua << EOF
require('avante_lib').load()
local config = {
  windows = {
    input = {
      border = "rounded",
      width = 60,
      height = 10,
    },
    output = {
      border = "rounded",
      width = 60,
      height = 20,
    },
    ask = {
      floating = true,
      border = "rounded",
      start_insert = true
    }
  }
}
local avante = require('avante')
avante.setup(config)
EOF
endif
