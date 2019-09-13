if &compatible
  set nocompatible
endif

let &shell = '/bin/sh'
let g:python3_host_prog = expand('~/.virtualenvs/neovim3/bin/python')
let g:python_host_prog  = expand('~/.virtualenvs/neovim2/bin/python')

set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/plugins')
  call dein#begin('~/.config/nvim/plugins')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('airblade/vim-rooter')
  call dein#add('cespare/vim-toml')
  call dein#add('dense-analysis/ale')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('fatih/vim-go')
  call dein#add('glts/vim-textobj-comment')
  call dein#add('ianks/vim-tsx')
  call dein#add('jeetsukumaran/vim-buffergator')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('jparise/vim-graphql')
  call dein#add('junegunn/fzf')
  call dein#add('junegunn/fzf.vim')
  call dein#add('kana/vim-textobj-user')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('LnL7/vim-nix')
  call dein#add('mxw/vim-jsx')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('MarcWeber/vim-addon-local-vimrc')
  call dein#add('pangloss/vim-javascript')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/dein.vim') " let dein manage itself
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-python/python-syntax')
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
set ruler

set t_Co=256

set background=dark
colorscheme jdkaplan

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set formatoptions+=n
set nofoldenable

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
set updatetime=250

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

map <silent> ;b :call fzf#run({
\    'source': map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'),
\    'sink': 'e',
\})<CR>

map <silent> ;f :call fzf#run({'source': 'rg --files --hidden', 'sink': 'e'})<CR>

function! s:escape(path)
	return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! RgHandler(line)
	let parts = split(a:line, ':')
	let [fn, lno] = parts[0 : 1]
	execute 'e '. s:escape(fn)
	execute lno
	normal! zz
endfunction

map <silent> ;g :call fzf#run({
\    'source': 'rg --vimgrep --no-heading --smart-case --hidden --regexp '.shellescape(input('Pattern: ')),
\    'sink': function('RgHandler'),
\    'options': '+m',
\})<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <C-n> deoplete#mappings#manual_complete()
autocmd CompleteDone * silent! pclose!
set completeopt+=noselect
set completeopt+=menuone
set completeopt+=longest

let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_fix_on_save = 1
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
let g:ale_linters = {
\    '-': [],
\    'go': [
\        'goimports',
\        'golangci-lint',
\        'gometalinter',
\        'go vet',
\        'go build',
\    ],
\    'bash': [
\        'shellcheck',
\    ],
\    'python': [
\        'flake8',
\        'mypy',
\    ],
\    'rust': [
\        'cargo',
\    ],
\    'sh': [
\        'shellcheck',
\    ],
\    'zsh': [
\        'shellcheck',
\    ],
\}
let g:ale_fixers = {
\    '-': [],
\    'css': [
\        'prettier',
\    ],
\    'elixir': [
\        'mix_format',
\    ],
\    'html': [
\        'prettier',
\    ],
\    'javascript': [
\        'prettier',
\    ],
\    'python': [
\        'black',
\    ],
\    'ruby': [
\        'rubocop',
\    ],
\    'rust': [
\        'rustfmt',
\    ],
\    'typescript': [
\        'prettier',
\    ],
\}
nmap <silent> ;n <Plug>(ale_next_wrap)
nmap <silent> ;N <Plug>(ale_previous_wrap)
nmap <silent> <Leader>e :lclose<CR>
nmap <silent> <Leader>E :lopen<CR>

let g:better_whitespace_enabled=1
let g:better_whitespace_filetypes_blacklist=[]
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

autocmd BufNewFile,BufRead *.tako set filetype=python

map <silent> <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>a :NERDTreeFind<CR>
noremap <leader>m :NERDTreeFind<Space>

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
let g:AutoPairsShortcutBackInsert = ''

let g:javascript_plugin_flow = 1
let g:ale_javascript_flow_use_respect_pragma = 0

let g:jsx_ext_required = 1

let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
map <silent> <leader>g :GitGutterToggle<CR>
nmap <silent> ]h <Plug>(GitGutterNextHunk)
nmap <silent> [h <Plug>(GitGutterPrevHunk)

command Crosshair :set virtualedit=all cursorcolumn
command NoCrosshair :set virtualedit= nocursorcolumn

let g:AutoPairsShortcutToggle = ''

autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript     setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType eruby          setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript     setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml           setlocal ts=2 sts=2 sw=2 expandtab

set secure
