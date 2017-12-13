if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/plugins')
  call dein#begin('~/.config/nvim/plugins')

  " let dein manage itself
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('fatih/vim-go')
  call dein#add('hdima/python-syntax')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('neomake/neomake')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('zchee/deoplete-go')

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

map ;n :nohlsearch<CR>

map ;h :wincmd h<CR>
map ;j :wincmd j<CR>
map ;k :wincmd k<CR>
map ;l :wincmd l<CR>

map ;" :split<CR>
map ;% :vsplit<CR>
map ;0 :close<CR>

map ;w :w<CR>
map ;q :q<CR>
map ;x :x<CR>

map ;b :Denite buffer<CR>
map ;f :Denite file_rec buffer<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
autocmd CompleteDone * silent! pclose!
set completeopt+=noselect
set completeopt+=menuone
set completeopt+=longest

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

call neomake#configure#automake('w')
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_go_enabled_makers = ['go', 'govet']
nmap <Leader>e :lopen<CR>

autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd BufNewFile,BufRead *.tako set filetype=python

map <leader>t :NERDTreeToggle<CR>
noremap <leader>a :NERDTreeFind<CR>

let g:python_highlight_all = 1

let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
