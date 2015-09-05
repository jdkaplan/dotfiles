" Vim color file jdkaplan

set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256
let colors_name = "jdkaplan"

hi Comment	    guifg=#aaaaaa    ctermfg=145    gui=none    cterm=none 
hi Constant	    guifg=#b987ff    ctermfg=141    gui=none    cterm=none 
hi Cursor	    guibg=#eeeeee    ctermbg=255    guifg=#262626    ctermfg=235    gui=none    cterm=none
hi CursorLine	    guifg=#ffffff    ctermfg=231    guibg=#404040    ctermbg=59    gui=none    cterm=none 
hi ColorColumn	    guifg=#ffffff    ctermfg=231    gui=none    cterm=none 
hi Directory	    guifg=#008b8b    ctermfg=33    gui=none    cterm=none 
hi Folded	    guibg=#555555    ctermbg=59    guifg=#ffd700    ctermfg=220    gui=none    cterm=none 
hi Function	    guifg=#00c8ff    ctermfg=45    gui=none    cterm=none 
hi Identifier	    guifg=#00c8ff    ctermfg=45    gui=none    cterm=none 
hi LineNr	    guifg=#c7c7c7    ctermfg=188    gui=none    cterm=none 
hi MatchParen	    guifg=#ff8d4f    ctermfg=209    guibg=#262626 ctermbg=235   gui=none    cterm=none
hi Normal	    guifg=#e4e4e4    ctermfg=254    guibg=#262626    ctermbg=235    gui=none    cterm=none 
hi NonText	    guibg=#444444    ctermbg=238    guifg=#81bed6    ctermfg=110    gui=none    cterm=none 
hi Number	    guifg=#ff8700    ctermfg=208    gui=none    cterm=none 
hi PreProc	    guifg=#3dc93a    ctermfg=77    gui=none    cterm=none 
hi Statement	    guifg=#3dc93a    ctermfg=77    gui=none    cterm=none 
hi Special	    guifg=#e4e4e4    ctermfg=254    gui=none    cterm=none 
hi SpecialKey	    guifg=#9acd32    ctermfg=113    gui=none    cterm=none 
hi StatusLine	    guibg=#444444    ctermbg=238    guifg=#eeeeee    ctermfg=255    gui=none    cterm=none 
hi StatusLineNC	    guifg=#777777    ctermfg=243    gui=none    cterm=none 
hi String	    guifg=#d49f02    ctermfg=178    gui=none    cterm=none 
hi StorageClass	    guifg=#e8cf0e    ctermfg=184    gui=none    cterm=none 
hi Title	    guifg=#e4e4e4    ctermfg=254    gui=none    cterm=none 
hi Todo	    guifg=#fffefc    ctermfg=231    gui=none    cterm=none guibg=#262626 ctermbg=235
hi Type	    guifg=#e8cf0e    ctermfg=184    gui=none    cterm=none 
hi Underlined	    guifg=#e4e4e4    ctermfg=254    gui=underline    cterm=underline 
hi VertSplit	    guifg=#474747    ctermfg=239    gui=none    cterm=none 
hi Visual	    guifg=#e4e4e4    ctermfg=254    guibg=#3a3a3a    ctermbg=237    gui=none    cterm=none 
