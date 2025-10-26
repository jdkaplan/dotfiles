vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("jdkaplan.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end

    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    already_waits = client:supports_method("textDocument/willSaveWaitUntil")
    can_fmt = client:supports_method("textDocument/formatting")
    if not already_waits and can_fmt then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("jdkaplan.lsp", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

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
    config = true,
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
    commit = "220446c8c86a280180d852efac60991eaf1a21d4",
    lazy = false,
    init = function()
      local gitsigns = require("gitsigns")

      local toggle = function(value)
        -- BUG: (?) If the blame delay is not zero, the setting can
        -- enter a race with cursor movement and leave a ghost blame in
        -- the buffer.

        show = not show
        gitsigns.toggle_current_line_blame(show)
        gitsigns.toggle_deleted(show)
        gitsigns.toggle_signs(show)
      end

      vim.keymap.set("n", "<leader>gg", toggle)
      vim.keymap.set("n", "[h", gitsigns.prev_hunk)
      vim.keymap.set("n", "]h", gitsigns.next_hunk)
    end,
    opts = {
      signcolumn = false,
      show_deleted = false,
      current_line_blame = false,
      current_line_blame_formatter = "  <author> <author_time:%Y-%m-%d> <summary>",
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = false,
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    init = function()
      local illuminate = require("illuminate")
      illuminate.configure({
        delay = 500,
      })
    end,
    keys = {
      {
        "<leader>ii",
        function()
          require("illuminate").toggle_buf()
        end,
      },
      {
        "<leader>in",
        function()
          require("illuminate").goto_next_reference()
        end,
      },
      {
        "<leader>ip",
        function()
          require("illuminate").goto_prev_reference()
        end,
      },
      {
        "<leader>if",
        function()
          require("illuminate").toggle_freeze_buf()
        end,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "┊",
      },
      scope = { enabled = false },
    },
  },
  {
    "andythigpen/nvim-coverage",
    requires = { "nvim-lua/plenary.nvim" },
    version = "*",
    config = function()
      require("coverage").setup({
        auto_reload = true,
        signs = {
          covered = { text = "▎" },
          partial = { text = "▌" },
          uncovered = { text = "█" },
        },
      })
    end,
  },
  {
    "pmouraguedes/sql-ghosty.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "jfryy/keytrail.nvim",
    url = "https://github.com/jdkaplan/keytrail.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      key_mapping = "<Space>j",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
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
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]{"] = "@block.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]}"] = "@block.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[{"] = "@block.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[}"] = "@block.outer",
            },
          },
        },

        ensure_installed = {
          "bash",
          "css",
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
    opts = {
      autotag = {
        enabled = true,
        enable_close_on_slash = false,
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "^0.1.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "MunifTanjim/nui.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    init = function()
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("aerial")
      telescope.load_extension("ui-select")

      local builtin = require("telescope.builtin")

      local function find_files(opts)
        opts = opts or {}
        opts["hidden"] = true
        return builtin.find_files(opts)
      end

      vim.keymap.set("n", "<Space>f", find_files)
      vim.keymap.set("n", "<Space>g", builtin.live_grep)
      vim.keymap.set("n", "<Space>b", builtin.buffers)
      vim.keymap.set("n", "<Space>*", builtin.grep_string)
      vim.keymap.set("n", "<Space>o", telescope.extensions.aerial.aerial)
      vim.keymap.set("n", "<Space>t", builtin.builtin)

      -- TODO: Delete these ; fake-leader bindings
      vim.keymap.set("n", ";f", find_files)
      vim.keymap.set("n", ";g", builtin.live_grep)
      vim.keymap.set("n", ";b", builtin.buffers)
      vim.keymap.set("n", ";*", builtin.grep_string)

      vim.keymap.set("i", "<C-G><C-F>", builtin.symbols)
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
              pcall(vim.api.nvim_win_set_cursor, 0, { row, col - 1 })
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
            "--iglob",
            "!.git",
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

  -- LSP
  {
    "nvimtools/none-ls.nvim",
    config = function(_plugin, opts)
      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

      local prettier_filetypes = {}
      for k, v in ipairs(null_ls.builtins.formatting.prettier.filetypes) do
        prettier_filetypes[k] = v
      end
      table.insert(prettier_filetypes, "htmldjango") -- Jinja templates

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = prettier_filetypes,
          }),
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      "neovim/nvim-lspconfig",
      {
        "mason-org/mason.nvim",
        opts = {
          PATH = "append",
        },
      },
    },
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
    build = "make install_jsregexp",
    init = function()
      local luasnip = require("luasnip")

      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascript", "react" })

      -- Put snippets in ./snippets/<filetype>.snippets
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load()

      local cmp = require("cmp")
      cmp.setup({
        completion = {
          autocomplete = false,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    keys = {
      {
        "<Leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<Leader>dB",
        function()
          require("dap").set_breakpoint()
        end,
      },
      {
        "<Leader>dc",
        function()
          require("dap").continue()
        end,
      },
      {
        "<Leader>dn",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<Leader>dsi",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<Leader>dso",
        function()
          require("dap").step_out()
        end,
      },
      {
        "<Leader>dj",
        function()
          require("dap").down()
        end,
      },
      {
        "<Leader>dk",
        function()
          require("dap").up()
        end,
      },
    },
  },
}
