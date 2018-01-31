if &compatible
  set nocompatible
endif

let &shell = '/bin/sh'

set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/plugins')
  call dein#begin('~/.config/nvim/plugins')

  " let dein manage itself
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('fatih/vim-go')
  call dein#add('kana/vim-textobj-user')
  call dein#add('glts/vim-textobj-comment')
  call dein#add('jeetsukumaran/vim-buffergator')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-python/python-syntax')
  call dein#add('w0rp/ale')
  call dein#add('zchee/deoplete-go', {'build': 'make'})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable
set number
set hidden

set t_Co=256

set background=dark
colorscheme jdkaplan

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set formatoptions+=n

set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

set ignorecase
set smartcase

set cursorline

set splitbelow
set splitright

set modelines=0
set lazyredraw

set shortmess+=I

set virtualedit=
set display+=lastline
noremap <silent> k gk
noremap <silent> j gj

map ; :
noremap ;; ;

map <silent> ;<Space> :nohlsearch<CR>

map ;h :wincmd h<CR>
map ;j :wincmd j<CR>
map ;k :wincmd k<CR>
map ;l :wincmd l<CR>

map ;" :split<CR>
map ;% :vsplit<CR>
map ;0 :close<CR>
map ;1 :only<CR>

map ;w :w<CR>
map ;q :q<CR>
map ;x :x<CR>

set wildignore+=*.swp,*~

map ;b :Denite buffer<CR>
map ;f :Denite file_rec buffer<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <C-n> deoplete#mappings#manual_complete()
autocmd CompleteDone * silent! pclose!
set completeopt+=noselect
set completeopt+=menuone
set completeopt+=longest

let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_fix_on_save = 1
let g:ale_linters = {
\    '-': [],
\    'go': [
\        'goimports',
\        'go vet',
\        'go build',
\    ],
\    'python': [
\        'flake8',
\        'mypy',
\    ],
\}
let g:ale_fixers = {
\    '-': [],
\    'python': [
\        'yapf',
\    ],
\}
nmap <silent> <Leader>n <Plug>(ale_previous_wrap)
nmap <silent> <Leader>N <Plug>(ale_next_wrap)
nmap <Leader>e :lopen<CR>
nmap <Leader>E :lclose<CR>

autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd BufNewFile,BufRead *.tako set filetype=python

map <leader>t :NERDTreeToggle<CR>
noremap <leader>a :NERDTreeFind<CR>

let g:python_highlight_all = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"

let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_autoupdate = 1
let g:buffergator_sort_regime = 'filepath'
let g:buffergator_display_regime = 'bufname'
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
map <leader>b :BuffergatorToggle<CR>

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
