hi clear
if exists("syntax_on")
syntax reset
endif
set background=dark
let colors_name = "jdkaplan-dark"

hi Normal               cterm=none      ctermfg=254 ctermbg=235
" hi link NormalFloat Pmenu

hi Cursor               cterm=none                  ctermbg=255
hi CursorLine           cterm=none                  ctermbg=232
hi! link CursorColumn CursorLine

hi LineNr               cterm=none      ctermfg=245 ctermbg=235
" hi link LineNrAbove LineNr
" hi link LineNrBelow LineNr
hi CursorLineNr         cterm=none      ctermfg=222 ctermbg=232
" hi link CursorLineSign SignColumn
" hi link CursorLineFold FoldColumn

hi DiffAdd ctermbg=22
hi DiffChange ctermbg=17
hi DiffDelete ctermbg=52
hi DiffText cterm=bold ctermbg=56

" hi IncSearch cterm=reverse
hi Search ctermfg=232 ctermbg=178

hi ErrorMsg NONE ctermfg=160
hi ModeMsg cterm=bold
" hi link MsgSeparator StatusLine
hi MoreMsg ctermfg=121
hi WarningMsg NONE ctermfg=220
hi Question ctermfg=121
" hi link QuickFixLine Search

hi Pmenu                cterm=none      ctermfg=254 ctermbg=238
hi PmenuSel             cterm=none      ctermfg=254 ctermbg=235
hi PmenuSbar            cterm=none                  ctermbg=236
hi PmenuThumb           cterm=none      ctermfg=254

hi SpellBad       NONE  cterm=underline
hi! link SpellCap   SpellBad
hi! link SpellLocal SpellBad
hi! link SpellRare  SpellBad

hi StatusLine           cterm=none      ctermfg=255 ctermbg=238
hi StatusLineNC         cterm=none      ctermfg=243 ctermbg=236
" TODO: TabLine
" TODO: TabLineSel
" TODO: TabLineFill

hi Visual               cterm=none      ctermfg=254 ctermbg=237

hi ColorColumn ctermbg=52
hi Conceal ctermfg=250 ctermbg=242
hi VertSplit            cterm=none      ctermfg=239
" hi link WinSeparator VertSplit
hi Folded               cterm=none      ctermfg=220 ctermbg=59
" TODO: FoldColumn
hi SignColumn                                       ctermbg=238

hi Directory            cterm=none      ctermfg=33

hi MatchParen           cterm=none      ctermfg=209 ctermbg=235
hi SpecialKey           cterm=none      ctermfg=113
hi Title                cterm=none      ctermfg=254
" TODO: WildMenu

hi NonText              cterm=none      ctermfg=110 ctermbg=238
" hi link EndOfBuffer NonText
hi Whitespace           cterm=none      ctermfg=239 ctermbg=235

hi Comment              cterm=none      ctermfg=145

hi Constant             cterm=none      ctermfg=141
" hi link Boolean Constant
" hi link Character Constant
hi String               cterm=none      ctermfg=178
hi Number               cterm=none      ctermfg=208
" hi link Float Number

hi Identifier           cterm=none      ctermfg=45
hi Function             cterm=none      ctermfg=45
hi Statement            cterm=none      ctermfg=77
" hi link Conditional Statement
" hi link Repeat Statement
" hi link Label Statement
" hi link Operator Statement
" hi link Keyword Statement
" hi link Exception Statement

hi PreProc              cterm=none      ctermfg=77
" hi link Include PreProc
" hi link Define PreProc
" hi link Macro PreProc
" hi link PreCondit PreProc

hi Type                 cterm=none      ctermfg=184
hi! link StorageClass Type
" hi link Structure Type
" hi link Typedef Type

hi Special              cterm=none      ctermfg=254
" hi link SpecialChar Special
" hi link Tag Special
" hi link Delimiter Special
" hi link SpecialComment Special
" hi link Debug Special

hi Underlined      NONE cterm=underline
hi Ignore ctermfg=232
hi Error ctermfg=255 ctermbg=124
hi Todo                 cterm=none      ctermfg=160 ctermbg=235

hi ExtraWhitespace      cterm=none                  ctermbg=160

hi ALEWarningSign                       ctermfg=184 ctermbg=238
hi ALEErrorSign                         ctermfg=160 ctermbg=238
