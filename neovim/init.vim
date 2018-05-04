if &compatible
  set nocompatible
endif

let &shell = '/bin/sh'
let g:python3_host_prog = expand('~/.virtualenvs/neovim3/bin/python')
let g:python_host_prog  = expand('~/.virtualenvs/neovim2/bin/python')

set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/plugins')
  call dein#begin('~/.config/nvim/plugins')

  " let dein manage itself
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('airblade/vim-rooter')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('fatih/vim-go')
  call dein#add('kana/vim-textobj-user')
  call dein#add('glts/vim-textobj-comment')
  call dein#add('jeetsukumaran/vim-buffergator')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('mxw/vim-jsx')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('pangloss/vim-javascript')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-python/python-syntax')
  call dein#add('w0rp/ale')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('zchee/deoplete-jedi')

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

map <silent> ;b :Denite buffer<CR>

map <silent> ;f :Denite file_rec<CR>
call denite#custom#var('file_rec', 'command',
\    ['rg', '--files', '--hidden'],
\)

map <silent> ;g :Denite grep<CR>
map <silent> ;* :DeniteCursorWord grep<CR>
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
\    ['--vimgrep', '--no-heading', '--smart-case', '--hidden'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#source('grep', 'converters', ['converter_abbr_word'])

call denite#custom#option("_", {
\    "highlight_matched_char": "DeniteMatched",
\    "highlight_matched_range": "None",
\})

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
\        'gometalinter',
\        'go vet',
\        'go build',
\    ],
\    'javascript': [
\        'flow',
\    ],
\    'python': [
\        'flake8',
\        'mypy',
\    ],
\}
let g:ale_fixers = {
\    '-': [],
\    'javascript': [
\        'prettier',
\    ],
\    'python': [
\        'yapf',
\    ],
\}
nmap <silent> ;n <Plug>(ale_next_wrap)
nmap <silent> ;N <Plug>(ale_previous_wrap)
nmap <silent> <Leader>e :lclose<CR>
nmap <silent> <Leader>E :lopen<CR>

autocmd BufEnter * EnableStripWhitespaceOnSave
autocmd BufNewFile,BufRead *.tako set filetype=python

map <silent> <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>a :NERDTreeFind<CR>
noremap <leader>m :NERDTreeFind<Space>

let g:python_highlight_all = 1

let g:jedi#completions_enabled = 0
let g:jedi#force_py_version = 3
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#rename_command = ""
let g:jedi#usages_command = ""

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
let g:buffergator_autodismiss_on_select = 0
map <silent> <leader>b :BuffergatorToggle<CR>

let g:neosnippet#snippets_directory='~/.config/nvim/neosnippets/neosnippets'
let g:neosnippet#disable_runtime_snippets = {
\    '_' : 1,
\}
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_completed_snippet=1

let g:rooter_manual_only = 1
let g:rooter_patterns = ['.root', '.git', '.git/']
noremap <silent> <leader>cd :execute 'cd' fnameescape(FindRootDirectory())<CR>:pwd<CR>

let g:AutoPairsMultilineClose = 0

let g:javascript_plugin_flow = 1
let g:ale_javascript_flow_use_respect_pragma = 0

let g:jsx_ext_required = 1
