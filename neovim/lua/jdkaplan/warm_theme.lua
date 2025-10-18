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
        CursorLine   { bg = '#eeeeee' }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        Directory    { fg = '#1B15FD' }, -- Directory names (and other special names in listings)
        DiffAdd      { bg = '#e5ffe5' }, -- Diff mode: Added line |diff.txt|
        DiffChange   { bg = '#d8e7ff' }, -- Diff mode: Changed line |diff.txt|
        DiffDelete   { bg = '#ffe5e8' }, -- Diff mode: Deleted line |diff.txt|
        DiffText     { bg = '#b2cfff', bold = true }, -- Diff mode: Changed text within a changed line |diff.txt|
        TermCursor   { Cursor }, -- Cursor in a focused terminal
        TermCursorNC {}, -- Cursor in an unfocused terminal
        ErrorMsg     {}, -- Error messages on the command line
        VertSplit    { fg = '#C6C6C6' }, -- Column separating vertically split windows
        Folded       {}, -- Line used for closed folds
        FoldColumn   { fg = '#337ADA', bg = '#C6C6C6' }, -- 'foldcolumn'
        SignColumn   { fg = '#000000', bg = '#C6C6C6' }, -- Column where |signs| are displayed
        LineNr       { fg = '#a6a6a6' }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { fg = '#1B15FD' }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen   { fg = '#FF5F00' }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg      { bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea      {}, -- Area for messages and cmdline
        MoreMsg      { bold = true }, -- |more-prompt|
        NonText      { fg = '#8EB1D5', bg = '#eeeeee' }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        EndOfBuffer  { fg = '#dddddd', bg = "#f8f8f8" }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        Normal       { fg = "#000000" }, -- Normal text
        NormalFloat  { bg = "#eeeeee" }, -- Normal text in floating windows.
        NormalNC     {}, -- normal text in non-current windows
        Pmenu        { bg = "#eeeeee" }, -- Popup menu: Normal item.
        PmenuSel     { bg = "#cccccc" }, -- Popup menu: Selected item.
        PmenuSbar    { bg = "#aaaaaa" }, -- Popup menu: Scrollbar.
        PmenuThumb   { bg = "#000000" }, -- Popup menu: Thumb of the scrollbar.
        Question     {  fg = '#005F00' }, -- |hit-enter| prompt and yes/no questions
        IncSearch    { reverse = true }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Search       { fg = '#000000', bg = '#D7AF00' }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        QuickFixLine { Search }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Substitute   { Search }, -- |:substitute| replacement text highlighting
        SpecialKey   { fg = '#84D45F' }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad     { underline = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap     { SpellBad }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal   { SpellBad }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare    { SpellBad }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine   { fg = '#000000', bg = '#C6C6C6' }, -- Status line of current window
        StatusLineNC { fg = '#808080', bg = '#C6C6C6' }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        MsgSeparator { StatusLine }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        TabLine      {}, -- Tab pages line, not active tab page label
        TabLineFill  {}, -- Tab pages line, where there are no labels
        TabLineSel   {}, -- Tab pages line, active tab page label
        Title        {}, -- Titles for output from ":set all", ":autocmd" etc.
        Visual       { reverse = true }, -- Visual mode selection
        VisualNOS    {}, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg   { fg = '#FFD700' }, -- Warning messages
        Whitespace   { fg = '#808080' }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        WildMenu     { fg = '#282A2E', bg = '#F0C674' }, -- Current match in 'wildmenu' completion

        Comment        { fg = '#666666' }, -- Any comment

        Constant       { fg = '#876FFF' }, -- (*) Any constant
        String         { fg = '#005F00' }, --   A string constant: "this is a string"
        Character      { Constant }, --   A character constant: 'c', '\n'
        Number         { fg = '#876FFF' }, --   A number constant: 234, 0xff
        Boolean        { Constant }, --   A boolean constant: TRUE, false
        Float          { Number }, --   A floating point constant: 2.3e10

        Identifier     { Normal }, -- (*) Any variable name
        Function       { fg = '#D75F00' }, --   Function name (also: methods for classes)

        Statement      { fg = '#880000' }, -- (*) Any statement
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

        Type           { fg = '#8700D7' }, -- (*) int, long, char, etc.
        StorageClass   { Type }, --   static, register, volatile, etc.
        Structure      { Type }, --   struct, union, enum, etc.
        Typedef        { Type }, --   A typedef

        Special        { fg = '#000000' }, -- (*) Any special symbol
        SpecialChar    { Special }, --   Special character in a constant
        Tag            { Special }, --   You can use CTRL-] on this
        Delimiter      { Special }, --   Character that needs attention
        SpecialComment { Special }, --   Special things inside a comment (e.g. '\n')
        Debug          { Special }, --   Debugging statements

        Underlined     { gui = "underline" }, -- Text that stands out, HTML links
        Ignore         { fg = '#E4E4E4' }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error          { fg = '#000000', bg = '#FF5F00' }, -- Any erroneous construct
        Todo           { fg = '#FF0000' }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        LspInlayHint                { Comment },
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
        DiagnosticVirtualTextError { fg = '#F32840'} , -- Used for "Error" diagnostic virtual text.
        DiagnosticVirtualTextWarn  { fg = '#F06D14'} , -- Used for "Warn" diagnostic virtual text.
        DiagnosticVirtualTextInfo  { fg = '#4E85DA'} , -- Used for "Info" diagnostic virtual text.
        DiagnosticVirtualTextHint  { fg = '#015F00'} , -- Used for "Hint" diagnostic virtual text.
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
        GitSignsAdd      { bg = '#90d68f', fg = '#FFFFFF' },
        GitSignsChange   { bg = '#80abed', fg = '#FFFFFF' },
        GitSignsDelete   { bg = '#f9acb5', fg = '#FFFFFF' },
        GitSignsCurrentLineBlame { CursorLine, fg = '#337ADA' },

        -- lukas-reineke/indent-blankline.nvim
        IblIndent { fg = "#eeeeee" },

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
