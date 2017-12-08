if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/plugins')
  call dein#begin('~/.config/nvim/plugins')

  " let dein manage itself
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('fatih/vim-go')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('neomake/neomake')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')

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

set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

set ignorecase
set smartcase

set cursorline
set cursorcolumn

set shortmess+=I

set virtualedit=
set display+=lastline
noremap <silent> k gk
noremap <silent> j gj

map ; :
noremap ;; ;

map ;n :nohlsearch<CR>

map ;h :wincmd h<CR>
map ;j :wincmd j<CR>
map ;k :wincmd k<CR>
map ;l :wincmd l<CR>

map ;" :split<CR>
map ;% :vsplit<CR>
map ;0 :close<CR>

map ;w :w<CR>

map ;b :Denite buffer<CR>
map ;e :Denite file_rec buffer<CR>
map ;f :Denite file_rec buffer<CR>
map ;q :q<CR>
map ;x :x<CR>

let g:deoplete#enable_at_startup = 1

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map gcc \c<Space>

call neomake#configure#automake('w')
set formatoptions+=n

autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd BufNewFile,BufRead *.tako set filetype=python
