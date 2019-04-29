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
  call dein#add('fatih/vim-go')
  call dein#add('glts/vim-textobj-comment')
  call dein#add('ianks/vim-tsx')
  call dein#add('jeetsukumaran/vim-buffergator')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('jparise/vim-graphql')
  call dein#add('kana/vim-textobj-user')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('LnL7/vim-nix')
  call dein#add('mxw/vim-jsx')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('pangloss/vim-javascript')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/dein.vim') " let dein manage itself
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
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
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_fix_on_save = 1
let g:ale_linters = {
\    '-': [],
\    'go': [
\        'goimports',
\        'gometalinter',
\        'go vet',
\        'go build',
\    ],
\    'bash': [
\        'shellcheck',
\    ],
\    'javascript': [
\        'flow',
\    ],
\    'python': [
\        'flake8',
\        'mypy',
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
\    'javascript': [
\        'prettier',
\    ],
\    'python': [
\        'black',
\    ],
\}
nmap <silent> ;n <Plug>(ale_next_wrap)
nmap <silent> ;N <Plug>(ale_previous_wrap)
nmap <silent> <Leader>e :lclose<CR>
nmap <silent> <Leader>E :lopen<CR>

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

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
nmap <silent> ]h <Plug>GitGutterNextHunk
nmap <silent> [h <Plug>GitGutterPrevHunk

" Sligthly adapted from
" https://github.com/fatih/vim-go/blob/32ae8640716530bd55062379177da51efb37dfd2/autoload/go/doc.vim#L75
let s:buf_nr = -1
function! s:FlowType() abort
    let content = system('npx flow type-at-pos '.fnameescape(expand('%')).' '.line('.').' '.col('.'))

    " botright new
    " setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    " call append(0, split(content, "\n"))

    " reuse existing buffer window if it exists otherwise create a new one
    let is_visible = bufexists(s:buf_nr) && bufwinnr(s:buf_nr) != -1
    if !bufexists(s:buf_nr)
        new
        sil file `="[Flow]"`
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        split
        execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    " if window was not visible then resize it
    if !is_visible
        " cap window height to 20, but resize it for smaller contents
        let max_height = go#config#DocMaxHeight()
        let content_height = len(split(content, "\n"))
        if content_height > max_height
            exe 'resize ' . max_height
        else
            exe 'resize ' . content_height
        endif
    endif

    setlocal filetype=js
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal iskeyword+=:
    setlocal iskeyword-=-

    setlocal modifiable
    %delete _
    call append(0, split(content, "\n"))
    sil $delete _
    setlocal nomodifiable
    sil normal! gg

    " close easily with <esc> or enter
    noremap <buffer> <silent> <CR> :<C-U>close<CR>
    noremap <buffer> <silent> <Esc> :<C-U>close<CR>
endfunction

command FlowTypeAtPos call s:FlowType()
autocmd FileType javascript nnoremap <buffer> <silent> K :FlowTypeAtPos<CR>

command Crosshair :set virtualedit=all cursorcolumn
command NoCrosshair :set virtualedit= nocursorcolumn

let g:AutoPairsShortcutToggle = ''
