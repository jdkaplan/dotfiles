runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
filetype plugin indent on
set number

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
set listchars=tab:>-,extends:>,precedes:<

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

map ;h :wincmd h<CR>
map ;j :wincmd j<CR>
map ;k :wincmd k<CR>
map ;l :wincmd l<CR>

map ;" :split<CR>
map ;% :vsplit<CR>
map ;0 :close<CR>

map ;w :w<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
