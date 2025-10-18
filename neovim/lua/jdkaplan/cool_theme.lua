local lush = require('lush')
local hsl = lush.hsl

local theme = lush(function(injected_functions)
    -- Required alias for treesitter groups.
    -- https://github.com/rktjmp/lush.nvim/issues/109
    local sym = injected_functions.sym

    return {
        ColorColumn  { bg = '#5F0000' }, -- Columns set with 'colorcolumn'
        Conceal      {}, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor       { reverse = true }, -- Character under the cursor
        lCursor      {}, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM     {}, -- Like Cursor, but used when in IME mode |CursorIM|
        CursorLine   { bg = '#000000' }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        Directory    { fg = '#007CFF'}, -- Directory names (and other special names in listings)
        DiffAdd      { bg = '#005F00' }, -- Diff mode: Added line |diff.txt|
        DiffChange   { bg = '#00005F' }, -- Diff mode: Changed line |diff.txt|
        DiffDelete   { bg = '#5f0000' }, -- Diff mode: Deleted line |diff.txt|
        DiffText     { bg = '#5F00D7', bold = true }, -- Diff mode: Changed text within a changed line |diff.txt|
        TermCursor   { Cursor }, -- Cursor in a focused terminal
        TermCursorNC {}, -- Cursor in an unfocused terminal
        ErrorMsg     { fg = '#D70000' }, -- Error messages on the command line
        VertSplit    { fg = '#4E4E4E' }, -- Column separating vertically split windows
        Folded       { fg = '#F0C674', bg = '#282A2E'}, -- Line used for closed folds
        FoldColumn   { fg = '#8ABEB7', bg = '#6C6C6C' }, -- 'foldcolumn'
        SignColumn   { FoldColumn }, -- Column where |signs| are displayed
        LineNr       { fg = '#a7a7a7' }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { fg = '#FFD787' }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen   { fg = '#FF875F' }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg      { bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea      {}, -- Area for messages and cmdline
        MoreMsg      { bold = true }, -- |more-prompt|
        NonText      { fg = '#87AFD7', bg = '#444444' }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        EndOfBuffer  { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        Normal       { fg = "#ffffff" }, -- Normal text
        NormalFloat  { bg = "#111111" }, -- Normal text in floating windows.
        NormalNC     {}, -- normal text in non-current windows
        Pmenu        { bg = "#111111" }, -- Popup menu: Normal item.
        PmenuSel     { bg = "#000000" }, -- Popup menu: Selected item.
        PmenuSbar    { bg = "#000000" }, -- Popup menu: Scrollbar.
        PmenuThumb   { bg = "#ffffff" }, -- Popup menu: Thumb of the scrollbar.
        Question     { fg = '#87FFAF' }, -- |hit-enter| prompt and yes/no questions
        IncSearch    { reverse = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Search       { fg = '#000000', bg = '#D7AF00' }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        QuickFixLine { Search }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Substitute   { Search }, -- |:substitute| replacement text highlighting
        SpecialKey   { fg = '#84D45F' }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad     { underline = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap     { SpellBad }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal   { SpellBad }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare    { SpellBad }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine   { fg = '#FFFFFF', bg = '#444444' }, -- Status line of current window
        StatusLineNC { fg = '#6D7073', bg = '#303030' }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        MsgSeparator { StatusLine }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        TabLine      {}, -- Tab pages line, not active tab page label
        TabLineFill  {}, -- Tab pages line, where there are no labels
        TabLineSel   {}, -- Tab pages line, active tab page label
        Title        {}, -- Titles for output from ":set all", ":autocmd" etc.
        Visual       { bg = '#3A3A3A' }, -- Visual mode selection
        VisualNOS    {}, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg   { fg = '#FFD700' }, -- Warning messages
        Whitespace   { fg = '#4E4E4E' }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        WildMenu     { fg = '#282A2E', bg = '#F0C674' }, -- Current match in 'wildmenu' completion

        Comment        { fg = '#AFAFAF' }, -- Any comment

        Constant       { fg = '#AF87FF' }, -- (*) Any constant
        String         { fg = '#D7AF00' }, --   A string constant: "this is a string"
        Character      { Constant }, --   A character constant: 'c', '\n'
        Number         { fg = '#FF8700' }, --   A number constant: 234, 0xff
        Boolean        { Constant }, --   A boolean constant: TRUE, false
        Float          { Number }, --   A floating point constant: 2.3e10

        Identifier     { Normal }, -- (*) Any variable name
        Function       { fg = '#00D7FF' }, --   Function name (also: methods for classes)

        Statement      { fg = '#5FD75F' }, -- (*) Any statement
        Conditional    { Statement }, --   if, then, else, endif, switch, etc.
        Repeat         { Statement }, --   for, do, while, etc.
        Label          { Statement }, --   case, default, etc.
        Operator       { Statement }, --   "sizeof", "+", "*", etc.
        Keyword        { Statement }, --   any other keyword
        Exception      { Statement }, --   try, catch, throw

        PreProc        { Statement }, -- (*) Generic Preprocessor
        Include        { Statement }, --   Preprocessor #include
        Define         { Statement }, --   Preprocessor #define
        Macro          { Statement }, --   Same as Define
        PreCondit      { Statement }, --   Preprocessor #if, #else, #endif, etc.

        Type           { fg = '#D7D700' }, -- (*) int, long, char, etc.
        StorageClass   { Type }, --   static, register, volatile, etc.
        Structure      { Type }, --   struct, union, enum, etc.
        Typedef        { Type }, --   A typedef

        Special        { fg = '#FFFFFF' }, -- (*) Any special symbol
        SpecialChar    { Special }, --   Special character in a constant
        Tag            { Special }, --   You can use CTRL-] on this
        Delimiter      { Special }, --   Character that needs attention
        SpecialComment { Special }, --   Special things inside a comment (e.g. '\n')
        Debug          { Special }, --   Debugging statements

        Underlined     { gui = "underline" }, -- Text that stands out, HTML links
        Ignore         { fg = '#000000' }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error          { fg = '#EEEEEE', bg = '#AF0000' }, -- Any erroneous construct
        Todo           { fg = '#D70000' }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        LspInlayHint                { fg = '#777777' },
        LspReferenceText            {} , -- Used for highlighting "text" references
        LspReferenceRead            {} , -- Used for highlighting "read" references
        LspReferenceWrite           {} , -- Used for highlighting "write" references
        LspCodeLens                 {} , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        LspCodeLensSeparator        {} , -- Used to color the seperator between two or more code lens.
        LspSignatureActiveParameter { bold = true } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        DiagnosticError            {} , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn             {} , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo             {} , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint             {} , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticVirtualTextError { fg = '#A54242' } , -- Used for "Error" diagnostic virtual text.
        DiagnosticVirtualTextWarn  { fg = '#DE935F' } , -- Used for "Warn" diagnostic virtual text.
        DiagnosticVirtualTextInfo  { fg = '#5F819D' } , -- Used for "Info" diagnostic virtual text.
        DiagnosticVirtualTextHint  { fg = '#777777' } , -- Used for "Hint" diagnostic virtual text.
        DiagnosticUnderlineError   { underline = true } , -- Used to underline "Error" diagnostics.
        DiagnosticUnderlineWarn    { underline = true } , -- Used to underline "Warn" diagnostics.
        DiagnosticUnderlineInfo    { underline = true } , -- Used to underline "Info" diagnostics.
        DiagnosticUnderlineHint    { underline = true } , -- Used to underline "Hint" diagnostics.
        DiagnosticFloatingError    { DiagnosticVirtualTextError } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        DiagnosticFloatingWarn     { DiagnosticVirtualTextWarn } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        DiagnosticFloatingInfo     { DiagnosticVirtualTextInfo } , -- Used to color "Info" diagnostic messages in diagnostics float.
        DiagnosticFloatingHint     { DiagnosticVirtualTextHint } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        DiagnosticSignError        { DiagnosticVirtualTextError } , -- Used for "Error" signs in sign column.
        DiagnosticSignWarn         { DiagnosticVirtualTextWarn } , -- Used for "Warn" signs in sign column.
        DiagnosticSignInfo         { DiagnosticVirtualTextInfo } , -- Used for "Info" signs in sign column.
        DiagnosticSignHint         { DiagnosticVirtualTextHint } , -- Used for "Hint" signs in sign column.

        -- lewis6991/gitsigns.nvim
        GitSignsAdd      { bg = '#328e30', fg = '#FFFFFF' },
        GitSignsChange   { bg = '#295493', fg = '#FFFFFF' },
        GitSignsDelete   { bg = '#af3140', fg = '#FFFFFF' },
        GitSignsCurrentLineBlame { CursorLine, fg = '#81aeea' },

        -- lukas-reineke/indent-blankline.nvim
        IblIndent { fg = "#000000" },

        -- RRethy/vim-illuminate
        IlluminatedWordText  { bold = true },
        IlluminatedWordRead  { IlluminatedWordText },
        IlluminatedWordWrite { IlluminatedWordText, underline = true },

        -- For :Lushify to work, the groups have to be spelled as `sym` called
        -- on a string literal.

        -- These match the default highlight groups from regex highlighting.
        sym"@text.literal"      { Comment },
        sym"@text.reference"    { Identifier },
        sym"@text.title"        { Title },
        sym"@text.uri"          { Underlined },
        sym"@text.underline"    { Underlined },
        sym"@text.todo"         { Todo },
        sym"@comment"           { Comment },
        sym"@punctuation"       { Delimiter },
        sym"@constant"          { Constant },
        sym"@constant.builtin"  { Constant },
        sym"@constant.macro"    { Define },
        sym"@define"            { Define },
        sym"@macro"             { Macro },
        sym"@string"            { String },
        sym"@string.escape"     { SpecialChar },
        sym"@string.special"    { SpecialChar },
        sym"@character"         { Character },
        sym"@character.special" { SpecialChar },
        sym"@number"            { Number },
        sym"@boolean"           { Boolean },
        sym"@float"             { Float },
        sym"@function"          { Function },
        sym"@function.builtin"  { Function },
        sym"@function.macro"    { Macro },
        sym"@parameter"         { Identifier },
        sym"@method"            { Function },
        sym"@field"             { Identifier },
        sym"@property"          { Identifier },
        sym"@constructor"       { Special },
        sym"@conditional"       { Conditional },
        sym"@repeat"            { Repeat },
        sym"@label"             { Label },
        sym"@operator"          { Operator },
        sym"@keyword"           { Keyword },
        sym"@exception"         { Exception },
        sym"@variable"          { Identifier },
        sym"@type"              { Type },
        sym"@type.definition"   { Typedef },
        sym"@storageclass"      { StorageClass },
        sym"@structure"         { Structure },
        sym"@namespace"         { Identifier },
        sym"@include"           { Include },
        sym"@preproc"           { PreProc },
        sym"@debug"             { Debug },

        -- These differ from regex highlighting. Sometimes this is an override,
        -- and sometimes the equivalent base highlight group doesn't exist.
        sym"@tag"               { Keyword },
        sym"@tag.attribute"     { Type },
    }
end)

return theme
