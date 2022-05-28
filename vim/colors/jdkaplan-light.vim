hi clear
if exists("syntax_on")
syntax reset
endif
set background=light
let colors_name = "jdkaplan-light"

hi Normal               cterm=none      ctermfg=233 ctermbg=255
" hi link NormalFloat Pmenu

hi Cursor               cterm=none                  ctermbg=232
hi CursorLine           cterm=none                  ctermbg=254
hi link CursorColumn CursorLine

hi LineNr               cterm=none      ctermfg=248 ctermbg=255
" hi link LineNrAbove LineNr
" hi link LineNrBelow LineNr
hi CursorLineNr         cterm=none      ctermfg=21  ctermbg=254
" hi link CursorLineSign SignColumn
" hi link CursorLineFold FoldColumn

hi DiffAdd ctermbg=193
hi DiffChange ctermbg=195
hi DiffDelete ctermbg=224
hi DiffText cterm=bold ctermbg=189

" hi IncSearch cterm=reverse
hi Search ctermfg=232 ctermbg=178

hi ErrorMsg NONE ctermfg=160
hi ModeMsg cterm=bold
" hi link MsgSeparator StatusLine
hi MoreMsg ctermfg=22
hi WarningMsg NONE ctermfg=88
hi Question ctermfg=22
" hi link QuickFixLine Search

hi Pmenu                cterm=none      ctermfg=233 ctermbg=251
hi PmenuSel             cterm=none      ctermfg=233 ctermbg=255
hi PmenuSbar            cterm=none                  ctermbg=251
hi PmenuThumb           cterm=none      ctermfg=233

hi SpellBad       NONE  cterm=underline
hi link SpellCap   SpellBad
hi link SpellLocal SpellBad
hi link SpellRare  SpellBad

hi StatusLine           cterm=none      ctermfg=232 ctermbg=245
hi StatusLineNC         cterm=none      ctermfg=244 ctermbg=251
" TODO: TabLine
" TODO: TabLineSel
" TODO: TabLineFill

hi Visual               cterm=none      ctermfg=233 ctermbg=252

hi ColorColumn ctermbg=52
hi Conceal ctermfg=250 ctermbg=242
hi VertSplit            cterm=none      ctermfg=248
" hi link WinSeparator VertSplit
hi Folded               cterm=none      ctermfg=27  ctermbg=254
" TODO: FoldColumn
hi SignColumn                                       ctermbg=251

hi Directory            cterm=none      ctermfg=26

hi MatchParen           cterm=none      ctermfg=202 ctermbg=255
hi SpecialKey           cterm=none      ctermfg=88
hi Title                cterm=none      ctermfg=233
" TODO: WildMenu

hi NonText              cterm=none      ctermfg=110 ctermbg=251
" hi link EndOfBuffer NonText
hi Whitespace           cterm=none      ctermfg=244 ctermbg=253

hi Comment              cterm=none      ctermfg=241

hi Constant             cterm=none      ctermfg=202
" hi link Boolean Constant
" hi link Character Constant
hi String               cterm=none      ctermfg=22
hi Number               cterm=none      ctermfg=99
" hi link Float Number

hi Identifier           cterm=none      ctermfg=166
hi Function             cterm=none      ctermfg=166
hi Statement            cterm=none      ctermfg=88
" hi link Conditional Statement
" hi link Repeat Statement
" hi link Label Statement
" hi link Operator Statement
" hi link Keyword Statement
" hi link Exception Statement

hi PreProc              cterm=none      ctermfg=88
" hi link Include PreProc
" hi link Define PreProc
" hi link Macro PreProc
" hi link PreCondit PreProc

hi Type                 cterm=none      ctermfg=92
hi link StorageClass Type
" hi link Structure Type
" hi link Typedef Type

hi Special              cterm=none      ctermfg=233
" hi link SpecialChar Special
" hi link Tag Special
" hi link Delimiter Special
" hi link SpecialComment Special
" hi link Debug Special

hi Underlined      NONE cterm=underline
hi Ignore ctermfg=254
hi Error ctermfg=232 ctermbg=124
hi Todo                 cterm=none      ctermfg=196 ctermbg=255

hi ExtraWhitespace      cterm=none                  ctermbg=160

hi ALEWarningSign                       ctermfg=184 ctermbg=249
hi ALEErrorSign                         ctermfg=160 ctermbg=249
