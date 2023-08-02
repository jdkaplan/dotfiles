return {
    -- Theme
    'rktjmp/lush.nvim',

    -- tpope extended universe
    "tpope/vim-abolish",
    "tpope/vim-commentary",
    "tpope/vim-endwise",
    "tpope/vim-repeat",
    { "kylechui/nvim-surround", config = true },
    {
        "tpope/vim-fugitive",
        keys = {
            { "<Space>G", ":Git<Space>", mode = "n" },
        },
    },

    -- etc.
    "MarcWeber/vim-addon-local-vimrc",
    "qpkorr/vim-bufkill",
    {
        "almo7aya/openingh.nvim",
        keys = {
            { "<Leader>gh", "V:OpenInGHFile<CR>", mode = {"n"} },
            { "<Leader>gh",  ":OpenInGHFile<CR>", mode = {"v"} },
        },
    },
    {
        "chrisbra/unicode.vim",
        lazy = false,
        dependencies = {
            "junegunn/fzf",
        },
        keys = {
            { "<C-G><C-F>", "<Plug>(UnicodeFuzzy)<cr>", mode = "i" },
        },
        init = function()
            vim.g.Unicode_no_default_mappings = 1
        end,
    },
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "x" },
            { "ga", "<Plug>(EasyAlign)", mode = "n" },
        },
    },
    {
        "ntpeters/vim-better-whitespace",
        init = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.better_whitespace_filetypes_blacklist = { 'diff' }
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.better_whitespace_operator = ''
        end,
    },
    {
        "windwp/nvim-autopairs",
        opts = {
            map_cr = true,
            enable_moveright = true,
            enable_check_bracket_line = false,
            check_ts = true,
        },
    },
}
