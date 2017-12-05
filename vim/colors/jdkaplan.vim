" Vim color file jdkaplan

set background=dark
hi clear
if exists("syntax_on")
syntax reset
endif
set t_Co=256
let colors_name = "jdkaplan"

hi Comment         cterm=none      ctermfg=145
hi Constant        cterm=none      ctermfg=141
hi Cursor          cterm=none                  ctermbg=255
hi CursorLine      cterm=none                  ctermbg=0
hi CursorColumn    cterm=none                  ctermbg=0
hi Directory       cterm=none      ctermfg=33
hi ExtraWhitespace cterm=none                  ctermbg=160
hi Folded          cterm=none      ctermfg=220 ctermbg=59
hi Function        cterm=none      ctermfg=45
hi Identifier      cterm=none      ctermfg=45
hi LineNr          cterm=none      ctermfg=188
hi MatchParen      cterm=none      ctermfg=209 ctermbg=235
hi Normal          cterm=none      ctermfg=254 ctermbg=235
hi NonText         cterm=none      ctermfg=110 ctermbg=238
hi Number          cterm=none      ctermfg=208
hi PreProc         cterm=none      ctermfg=77
hi Statement       cterm=none      ctermfg=77
hi Special         cterm=none      ctermfg=254
hi SpecialKey      cterm=none      ctermfg=113
hi StatusLine      cterm=none      ctermfg=255 ctermbg=238
hi StatusLineNC    cterm=none      ctermfg=243 ctermbg=236
hi String          cterm=none      ctermfg=178
hi StorageClass    cterm=none      ctermfg=184
hi Title           cterm=none      ctermfg=254
hi Todo            cterm=none      ctermfg=160 ctermbg=235
hi Type            cterm=none      ctermfg=184
hi Underlined      cterm=underline ctermfg=254
hi VertSplit       cterm=none      ctermfg=239
hi Visual          cterm=none      ctermfg=254 ctermbg=237
