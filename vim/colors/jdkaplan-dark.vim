hi clear
if exists("syntax_on")
syntax reset
endif
set background=dark
let colors_name = "jdkaplan-dark"

hi Comment              cterm=none      ctermfg=145
hi Constant             cterm=none      ctermfg=141
hi Cursor               cterm=none                  ctermbg=255
hi CursorLine           cterm=none                  ctermbg=232
hi CursorLineNr         cterm=none      ctermfg=222 ctermbg=232
hi CursorColumn         cterm=none                  ctermbg=232
hi Directory            cterm=none      ctermfg=33
hi ExtraWhitespace      cterm=none                  ctermbg=160
hi Folded               cterm=none      ctermfg=220 ctermbg=59
hi Function             cterm=none      ctermfg=45
hi Identifier           cterm=none      ctermfg=45
hi LineNr               cterm=none      ctermfg=245 ctermbg=235
hi MatchParen           cterm=none      ctermfg=209 ctermbg=235
hi Normal               cterm=none      ctermfg=254 ctermbg=235
hi NonText              cterm=none      ctermfg=110 ctermbg=238
hi Number               cterm=none      ctermfg=208
hi Pmenu                cterm=none      ctermfg=254 ctermbg=238
hi PmenuSel             cterm=none      ctermfg=254 ctermbg=235
hi PmenuSbar            cterm=none      ctermbg=236
hi PmenuThumb           cterm=none      ctermfg=254
hi PreProc              cterm=none      ctermfg=77
hi SignColumn                                       ctermbg=238
hi Statement            cterm=none      ctermfg=77
hi Special              cterm=none      ctermfg=254
hi SpecialKey           cterm=none      ctermfg=113
hi SpellBad       NONE  cterm=underline
hi SpellCap       NONE  cterm=underline
hi StatusLine           cterm=none      ctermfg=255 ctermbg=238
hi StatusLineNC         cterm=none      ctermfg=243 ctermbg=236
hi String               cterm=none      ctermfg=178
hi StorageClass         cterm=none      ctermfg=184
hi Title                cterm=none      ctermfg=254
hi Todo                 cterm=none      ctermfg=160 ctermbg=235
hi Type                 cterm=none      ctermfg=184
hi Underlined           cterm=underline ctermfg=254
hi VertSplit            cterm=none      ctermfg=239
hi Visual               cterm=none      ctermfg=254 ctermbg=237
hi Whitespace           cterm=none      ctermfg=239 ctermbg=235

hi ALEWarningSign                       ctermfg=184 ctermbg=238
hi ALEErrorSign                         ctermfg=160 ctermbg=238
