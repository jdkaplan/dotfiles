" Vim color file jdkaplan

hi clear
if exists("syntax_on")
syntax reset
endif
set background=light
let colors_name = "jdkaplan2"

hi Comment              cterm=none      ctermfg=243
hi Constant             cterm=none      ctermfg=63
hi Cursor               cterm=none                  ctermbg=232
hi CursorLine           cterm=none                  ctermbg=255
hi CursorColumn         cterm=none                  ctermbg=255
hi Directory            cterm=none      ctermfg=26
hi ExtraWhitespace      cterm=none                  ctermbg=160
hi Folded               cterm=none      ctermfg=220 ctermbg=242
hi Function             cterm=none      ctermfg=32
hi Identifier           cterm=none      ctermfg=32
hi LineNr               cterm=none      ctermfg=244
hi MatchParen           cterm=none      ctermfg=202 ctermbg=254
hi Normal               cterm=none      ctermfg=233 ctermbg=254
hi NonText              cterm=none      ctermfg=110 ctermbg=251
hi Number               cterm=none      ctermfg=202
hi PreProc              cterm=none      ctermfg=28
hi SignColumn                                       ctermbg=242
hi Statement            cterm=none      ctermfg=28
hi Special              cterm=none      ctermfg=233
hi SpecialKey           cterm=none      ctermfg=28
hi SpellBad       NONE  cterm=underline " TODO
hi SpellCap       NONE  cterm=underline " TODO
hi StatusLine           cterm=none      ctermfg=232 ctermbg=245
hi StatusLineNC         cterm=none      ctermfg=244 ctermbg=251
hi String               cterm=none      ctermfg=94
hi StorageClass         cterm=none      ctermfg=136
hi Title                cterm=none      ctermfg=233
hi Todo                 cterm=none      ctermfg=196 ctermbg=254
hi Type                 cterm=none      ctermfg=136
hi Underlined           cterm=underline ctermfg=233
hi VertSplit            cterm=none      ctermfg=248
hi Visual               cterm=none      ctermfg=233 ctermbg=252
hi Whitespace           cterm=none      ctermfg=244 ctermbg=253

hi ALEWarningSign                       ctermfg=184 ctermbg=249
hi ALEErrorSign                         ctermfg=160 ctermbg=249
