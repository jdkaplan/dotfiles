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

map <silent> ;<Space> :nohlsearch<CR>

map <silent> ;h :wincmd h<CR>
map <silent> ;j :wincmd j<CR>
map <silent> ;k :wincmd k<CR>
map <silent> ;l :wincmd l<CR>

map <silent> ;" :split<CR>
map <silent> ;% :vsplit<CR>
map <silent> ;0 :close<CR>
map <silent> ;1 :only<CR>

map <silent> ;w :w<CR>
map <silent> ;q :q<CR>
map <silent> ;x :x<CR>

set wildignore+=*.swp,*~
