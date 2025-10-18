local bufnr = vim.api.nvim_get_current_buf()

function rustLspMap(mode, keys, cmd)
    vim.keymap.set(
        mode,
        keys,
        function() vim.cmd.RustLsp(cmd) end,
        { silent = true, buffer = bufnr }
    )
end

-- Use rust-analyzer's grouping of actions
rustLspMap("n", "gra", "codeAction")

-- Use rustaceanvim's hover actions
rustLspMap("n", "K", {'hover', 'actions'})
