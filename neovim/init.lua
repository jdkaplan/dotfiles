vim.o.shell = '/bin/sh'
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim3/bin/python")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
    vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end
vim.opt.rtp:prepend(lazypath)

-- Load from ./lua/plugins/*.lua
require("lazy").setup("plugins", {
    change_detection = {
        -- Disable automatic reloading of config files.
        enabled = false,
    }
})

theme = "jdkaplan-temp"

vim.o.number = true
vim.o.hidden = true

vim.cmd.colorscheme(theme)

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.opt.formatoptions = "crqnlj"
vim.o.foldenable = false
vim.o.joinspaces = false

vim.o.wrap = true
vim.o.linebreak = true
vim.keymap.set("", "j", "gj", { silent = true })
vim.keymap.set("", "k", "gk", { silent = true })

vim.o.list = false
vim.o.wrapmargin = 0
vim.opt.listchars = {
    tab = ">-",
    extends = ">",
    precedes = "<",
    nbsp = "+",
    trail = "-",
}

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.modelines = 0
vim.o.lazyredraw = true
vim.o.updatetime = 250

vim.opt.shortmess:append("I")

vim.opt.wildignore:append("*.swp,*~")

vim.opt.completeopt = "menu,menuone,noselect"

vim.o.secure = true

vim.keymap.set("", "<Space>w", "<C-w>")
-- <Space>wh <C-w>h
-- <Space>wj <C-w>j
-- <Space>wk <C-w>k
-- <Space>wl <C-w>l
vim.keymap.set("", '<Space>w"', ":split<CR>")
vim.keymap.set("", '<Space>w%', ":vsplit<CR>")
vim.keymap.set("", '<Space>w0', ":close<CR>")
vim.keymap.set("", '<Space>w1', ":only<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ";h", ":wincmd h<CR>")
vim.keymap.set("", ";j", ":wincmd j<CR>")
vim.keymap.set("", ";k", ":wincmd k<CR>")
vim.keymap.set("", ";l", ":wincmd l<CR>")

vim.keymap.set("", ';"', ":split<CR>")
vim.keymap.set("", ';%', ":vsplit<CR>")
vim.keymap.set("", ';0', ":close<CR>")
vim.keymap.set("", ';1', ":only<CR>")

vim.keymap.set("", '<Leader>w', ":w<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ';w', ":w<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ';;', ";")

vim.keymap.set("", "<Space><Space>", ":nohlsearch<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ";<Space>", ":nohlsearch<CR>")

vim.keymap.set("n", "<Space>cc", ':let @+=expand("%")<CR>')
vim.keymap.set("n", "<Space>cl", ':let @+=join([expand("%"), line(".")], ":")<CR>')
vim.keymap.set("n", "<Space>cp", ':let @+=expand("%:p")<CR>')

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("n", ";cc", ':let @+=expand("%")<CR>')
vim.keymap.set("n", ";cl", ':let @+=join([expand("%"), line(".")], ":")<CR>')
vim.keymap.set("n", ";cp", ':let @+=expand("%:p")<CR>')

vim.cmd([[
command Crosshair :set virtualedit=all cursorcolumn
command NoCrosshair :set virtualedit= nocursorcolumn
]])

vim.cmd([[
autocmd FileType markdown setlocal spell
autocmd FileType text     setlocal spell
]])
vim.opt.spellcapcheck = ""

-- CTRL-L usually clears and redraws the screen.  Might as well use it to reset
-- the colorscheme too!
vim.keymap.set("n", "<C-l>", function()
    vim.cmd.colorscheme(theme)
    vim.cmd.redraw()
end)
