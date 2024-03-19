return {
    -- HUD
    {
        "preservim/nerdtree",
        keys = {
            { "<leader>t", ":NERDTreeToggle<cr>" },
            { "<leader>a", ":NERDTreeFind<cr>" },
        },
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>m", "<cmd>AerialToggle<cr>" },
            { "<leader>n", "<cmd>AerialNavToggle<cr>" },
        },
        config =true,
    },
    {
        "wellle/context.vim",
        lazy = false,
        init = function()
            vim.g.context_enabled = 0
            vim.keymap.set("", "<leader>cc", ":ContextToggleWindow<CR>", { silent = true })
            vim.keymap.set("", "<leader>cp", ":ContextPeek<CR>", { silent = true })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        init = function()
            local gitsigns = require("gitsigns")

            local toggle = function(value)
                -- BUG: (?) If the blame delay is not zero, the setting can
                -- enter a race with cursor movement and leave a ghost blame in
                -- the buffer.

                gitsigns.toggle_current_line_blame(value)
                gitsigns.toggle_signs(value)
            end

            vim.keymap.set("n", "<leader>g", toggle)
            vim.keymap.set("n", "]h", gitsigns.next_hunk)
            vim.keymap.set("n", "[h", gitsigns.prev_hunk)
        end,
        config = {
            signcolumn = false,
            signs = {
                add          = { hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
                change       = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
                delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
                topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
                changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
                untracked    = { hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
            },
            current_line_blame_formatter = '  <author> <author_time:%Y-%m-%d> <summary>',
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 0,
                ignore_whitespace = false,
            },
        },
    },
    {
        "RRethy/vim-illuminate",
        keys = {
            { "<leader>i", ":IlluminateToggle<cr>" },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        init = function()
            require('nvim-treesitter.configs').setup({
                highlight             = { enable = true },
                incremental_selection = { enable = true },

                textobjects = {
                    enable = true,
                    select = {
                        enable = true,

                        lookahead = true,

                        include_surrounding_whitespace = false,

                        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#overriding-or-extending-textobjects
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@comment.outer",
                            ["ic"] = "@comment.outer",
                        },
                    },
                },

                ensure_installed = {
                    "bash",
                    "css",
                    "dockerfile",
                    "dot",
                    "diff",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",
                    "html",
                    "javascript",
                    "jq",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "proto",
                    "python",
                    "ruby",
                    "rust",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "yaml",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "windwp/nvim-ts-autotag",
        config = {
            autotag = {
                enabled = true,
                enable_close_on_slash = false,
            },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        version = '^0.1.0',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "MunifTanjim/nui.nvim",
            "stevearc/aerial.nvim",
        },
        init = function()
            local telescope = require('telescope')
            telescope.load_extension('fzf')
            telescope.load_extension('aerial')
            telescope.load_extension('ui-select')

            local builtin = require('telescope.builtin')

            local function find_files(opts)
                opts = opts or {}
                opts['hidden'] = true
                return builtin.find_files(opts)
            end

            vim.keymap.set('n', '<Space>f', find_files)
            vim.keymap.set('n', '<Space>g', builtin.live_grep)
            vim.keymap.set('n', '<Space>b', builtin.buffers)
            vim.keymap.set('n', '<Space>*', builtin.grep_string)
            vim.keymap.set('n', '<Space>o', telescope.extensions.aerial.aerial)

            -- TODO: Delete these ; fake-leader bindings
            vim.keymap.set('n', ';f', find_files)
            vim.keymap.set('n', ';g', builtin.live_grep)
            vim.keymap.set('n', ';b', builtin.buffers)
            vim.keymap.set('n', ';*', builtin.grep_string)
        end,
        opts = function(_plugin, _config)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            local transform_mod = require("telescope.actions.mt").transform_mod

            -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1225975038
            local function multiopen(prompt_bufnr, method)
                local method = method or "default"

                local edit_file_cmd_map = {
                    vertical = "vsplit",
                    horizontal = "split",
                    tab = "tabedit",
                    default = "edit",
                }
                local edit_buf_cmd_map = {
                    vertical = "vert sbuffer",
                    horizontal = "sbuffer",
                    tab = "tab sbuffer",
                    default = "buffer",
                }

                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selection = picker:get_multi_selection()

                if #multi_selection > 1 then
                    require("telescope.pickers").on_close_prompt(prompt_bufnr)
                    pcall(vim.api.nvim_set_current_win, picker.original_win_id)

                    for i, entry in ipairs(multi_selection) do
                        local filename, row, col

                        if entry.path or entry.filename then
                            filename = entry.path or entry.filename

                            row = entry.row or entry.lnum
                            col = vim.F.if_nil(entry.col, 1)
                        elseif not entry.bufnr then
                            local value = entry.value
                            if not value then
                                goto continue
                            end

                            if type(value) == "table" then
                                value = entry.display
                            end

                            local sections = vim.split(value, ":")

                            filename = sections[1]
                            row = tonumber(sections[2])
                            col = tonumber(sections[3])
                        end

                        local entry_bufnr = entry.bufnr

                        if entry_bufnr then
                            if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                                vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                            end
                            local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                            pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
                        else
                            local command = i == 1 and "edit" or edit_file_cmd_map[method]
                            if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                                filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                                pcall(vim.cmd, string.format("%s %s", command, filename))
                            end
                        end

                        if row and col then
                            pcall(vim.api.nvim_win_set_cursor, 0, { row, col-1 })
                        end

                        ::continue::
                    end
                else
                    actions["select_" .. method](prompt_bufnr)
                end
            end

            return {
                defaults = {
                    mappings = {
                        i = {
                            ["<CR>"] = multiopen,
                        },
                        n = {
                            ["<CR>"] = multiopen,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        -- Include hidden files, but continue ignoring the .git directory itself.
                        "--hidden",
                        "--iglob", "!.git",
                    },
                },
                pickers = {},
                extensions = {
                    aerial = {},
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    -- Mason + LSP
    "alaviss/nim.nvim",
    "simrat39/rust-tools.nvim",
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        build = function(_plugin)
            require("mason-registry").refresh()
        end,
        config = {
            PATH = "append",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
        config = function(_plugin, opts)
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(opts)

            local lsp_settings = {
                rust_analyzer = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
                gopls = {
                    gofumpt = true,
                },
                sorbet = {}, -- This one is _extra_ special for some reason.
            }

            local on_attach = function(client, bufno)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufno, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufno, ...) end

                -- Enable completion through omnifunc, triggered by <C-x><C-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap=true, silent=true }

                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<Leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                buf_set_keymap('v', '<Leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
                buf_set_keymap('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            end

            local default_setup = function(server_name)
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                require("lspconfig")[server_name].setup({
                    on_attach = function(client, bufno)
                        on_attach(client, bufno)
                        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
                    end,
                    settings = lsp_settings[server_name] or {},
                    capabilities = capabilities,
                })
            end

            mason_lspconfig.setup_handlers({
                -- This is the default handler for servers not named below.
                default_setup,

                ["gopls"] = function()
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()

                    require("lspconfig")["gopls"].setup({
                        on_attach = on_attach,
                        settings = lsp_settings["gopls"] or {},
                        capabilities = capabilities,
                    })

                    -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        pattern = "*.go",
                        callback = function()
                            local params = vim.lsp.util.make_range_params()
                            params.context = {only = {"source.organizeImports"}}

                            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)

                            for cid, res in pairs(result or {}) do
                                for _, r in pairs(res.result or {}) do
                                    if r.edit then
                                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                                    end
                                end
                            end

                            vim.lsp.buf.format({async = false})
                        end
                    })
                end,

                ["rust_analyzer"] = function()
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()

                    -- rust-analyzer will be configured by rust-tools. Don't use lspconfig
                    -- directly (or through the default setup) for this.
                    local rt = require('rust-tools')

                    rt.setup({
                        tools = {
                            autoSetHints = true,
                            hover_with_actions = false,
                            inlay_hints = {
                                only_current_line = true,
                                -- Parameter hints are more annoying than useful here. Neovim can't show
                                -- virtual text in the middle of the line like other editors do. It would
                                -- mess with grid-based motion anyway.
                                show_parameter_hints = false,
                                parameter_hints_prefix = "",
                                other_hints_prefix = "//",
                            },
                        },

                        server = {
                            standalone = false,
                            capabilities = capabilities,
                            on_attach = function(client, bufno)
                                on_attach(client, bufno)

                                vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

                                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufno })
                            end,
                            settings = lsp_settings.rust_analyzer,
                        },

                        dap = {
                            adapter = require('rust-tools.dap').get_codelldb_adapter(
                                '/usr/bin/codelldb',
                                '/usr/lib/liblldb.so'
                            ),
                        },
                    })
                end,

                ["sorbet"] = function()
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()

                    require("lspconfig").sorbet.setup({
                        on_attach = function(client, bufno)
                            on_attach(client, bufno)
                        end,
                        cmd = { "bundle", "exec", "srb", "typecheck", "--lsp", "--disable-watchman" },
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },

    -- Completion + snippets
    { "hrsh7th/cmp-nvim-lsp", branch = "main" },
    { "hrsh7th/nvim-cmp", branch = "main" },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        init = function()
            local luasnip = require('luasnip')

            -- Put snippets in ./snippets/<filetype>.snippets
            require("luasnip.loaders.from_snipmate").lazy_load()

            local cmp = require('cmp')
            cmp.setup {
                completion = {
                    autocomplete = false,
                },
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
            }
        end,
    },

    -- Debugging
    {
        'mfussenegger/nvim-dap',
        lazy = false,
        keys = {
            { "<Leader>db", function() require('dap').toggle_breakpoint() end },
            { "<Leader>dB", function() require('dap').set_breakpoint() end },
            { "<Leader>dc", function() require('dap').continue() end },
            { "<Leader>dn", function() require('dap').step_over() end },
            { "<Leader>dsi", function() require('dap').step_into() end },
            { "<Leader>dso", function() require('dap').step_out() end },
            { "<Leader>dj", function() require('dap').down() end },
            { "<Leader>dk", function() require('dap').up() end },
        },
    },
}
