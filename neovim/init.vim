if &compatible
  set nocompatible
endif

let &shell = '/bin/sh'
let g:python3_host_prog = expand('~/.virtualenvs/neovim3/bin/python')
let g:loaded_python_provider = 0 " Disable python2 support for plugins

call plug#begin('~/.local/share/nvim/plugged')
if filereadable(expand("~/.config/nvim/os-plugins.vim"))
    source ~/.config/nvim/os-plugins.vim
endif
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'chrisbra/unicode.vim'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'glts/vim-textobj-comment'
Plug 'ianks/vim-tsx'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ledger/vim-ledger'
Plug 'LnL7/vim-nix'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'qpkorr/vim-bufkill'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'sirtaj/vim-openscad'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim'
Plug 'urbit/hoon.vim'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
call plug#end()

filetype plugin indent on
syntax enable
set number
set hidden
set ruler

colorscheme jdkaplan

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set formatoptions-=to
set formatoptions+=crqnlj
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

map <silent> ;b :Buffers<CR>
map <silent> ;f :call fzf#run({'source': 'rg --files --hidden', 'sink': 'e', 'options': '--multi'})<CR>

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
\    'options': '--multi',
\})<CR>
map <silent> ;* :call fzf#run({
\    'source': 'rg --vimgrep --no-heading --smart-case --hidden --regexp '.shellescape(expand('<cword>')),
\    'sink': function('RgHandler'),
\    'options': '--multi',
\})<CR>

command ALEOff :let b:ale_fix_on_save = 0
let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_fix_on_save = 1
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
let g:ale_linters = {
\    '-': [],
\    'arduino': [
\        'clang-tidy',
\    ],
\    'bash': [
\        'shellcheck',
\    ],
\    'css': [
\        'stylelint',
\    ],
\    'go': [
\        'go build',
\        'goimports',
\        'golangci-lint',
\        'go vet',
\    ],
\    'javascript': [
\        'eslint',
\    ],
\    'proto': [
\        'protolint',
\    ],
\    'python': [
\        'flake8',
\        'mypy',
\    ],
\    'ruby': [
\        'rubocop',
\        'sorbet',
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
\    'arduino': [
\        'clang-format',
\    ],
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
\        'eslint',
\        'prettier',
\    ],
\    'python': [
\        'black',
\    ],
\    'ruby': [
\        'rubocop',
\    ],
\    'scss': [
\        'prettier',
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
let g:better_whitespace_operator=''

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

let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_autoupdate = 1
let g:buffergator_sort_regime = 'filepath'
let g:buffergator_display_regime = 'bufname'
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autodismiss_on_select = 0
map <silent> <leader>b :BuffergatorToggle<CR>

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

autocmd FileType css            setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType scss           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript     setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jinja          setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jinja.html     setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType eruby          setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript     setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml           setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType proto          setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType markdown setlocal commentstring=<!--%s-->
autocmd FileType hoon     setlocal commentstring=::%s

set secure

autocmd FileType markdown setlocal spell
autocmd FileType text     setlocal spell
set spellcapcheck=

autocmd BufNewFile,BufRead *.arb set filetype=ruby
autocmd BufNewFile,BufRead *.html.erb set filetype=eruby.html

autocmd FileType ledger nmap <silent> <leader>' :call ledger#transaction_state_toggle(line('.'), ' !*')<CR>

nmap ;cc :let @+=expand("%")<CR>
nmap ;cp :let @+=expand("%:p")<CR>

" For some reason, (neo)vim sees <C-/> as <C-_>, so bind that instead.
autocmd FileType html inoremap <C-_> </<C-X><C-O>

let g:Unicode_no_default_mappings = 1
imap <C-G><C-F> <Plug>(UnicodeFuzzy)

" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" CTRL-L usually clears and redraws the screen.  Might as well use it to reset
" the colorscheme too!
fun s:ResetScreen()
    colorscheme jdkaplan
    redraw
endfun
command ResetScreen call s:ResetScreen()
nnoremap <C-l> :ResetScreen<CR>

nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)
