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
    {
        "tummetott/unimpaired.nvim",
        opts = {
            keymaps = {
                -- Tags
                tprevious = false,
                tnext = false,
                tfirst = false,
                tlast = false,
                ptprevious = false,
                ptnext = false,

                -- Files
                previous_file = false,
                next_file = false,

                -- Settings
                enable_cursorline = false,
                disable_cursorline = false,
                toggle_cursorline = false,
                enable_diff = false,
                disable_diff = false,
                toggle_diff = false,
                enable_hlsearch = false,
                disable_hlsearch = false,
                toggle_hlsearch = false,
                enable_ignorecase = false,
                disable_ignorecase = false,
                toggle_ignorecase = false,
                enable_list = false,
                disable_list = false,
                toggle_list = false,
                enable_number = false,
                disable_number = false,
                toggle_number = false,
                enable_relativenumber = false,
                disable_relativenumber = false,
                toggle_relativenumber = false,
                enable_spell = false,
                disable_spell = false,
                toggle_spell = false,
                enable_background = false,
                disable_background = false,
                toggle_background = false,
                enable_colorcolumn = false,
                disable_colorcolumn = false,
                toggle_colorcolumn = false,
                enable_cursorcolumn = false,
                disable_cursorcolumn = false,
                toggle_cursorcolumn = false,
                enable_virtualedit = false,
                disable_virtualedit = false,
                toggle_virtualedit = false,
                enable_wrap = false,
                disable_wrap = false,
                toggle_wrap = false,
                enable_cursorcross = false,
                disable_cursorcross = false,
                toggle_cursorcross = false,
            }
        }
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
            vim.g.better_whitespace_filetypes_blacklist = { 'diff', 'zig' }
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

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            keys = {
                Up = " ",
                Down = " ",
                Left = " ",
                Right = " ",
                C = "^",
                M = "M-",
                D = "W-",
                S = "S-",
                CR = "CR",
                Esc = "Esc",
                ScrollWheelDown = "⤓",
                ScrollWheelUp = "⤒",
                NL = "⏎",
                BS = "⇐",
                Space = "Space",
                Tab = "Tab",
                F1  = "F1",
                F2  = "F2",
                F3  = "F3",
                F4  = "F4",
                F5  = "F5",
                F6  = "F6",
                F7  = "F7",
                F8  = "F8",
                F9  = "F9",
                F10 = "F10",
                F11 = "F11",
                F12 = "F12",
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
