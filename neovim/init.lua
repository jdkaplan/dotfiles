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
vim.o.foldenable = false
vim.o.joinspaces = false
vim.o.nrformats = vim.o.nrformats .. ",blank"

-- Some ftplugin files will add 'o' back in again, so remove it again after the
-- filetype has been determined.
vim.opt.formatoptions = "crqnlj"
vim.cmd([[ autocmd Filetype * setlocal formatoptions-=o ]])

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

vim.keymap.set("", "<Space>w", "<C-w>", { remap = true })
vim.keymap.set("", '<Space>w"', ":split<CR>")
vim.keymap.set("", '<Space>w%', ":vsplit<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ";h", ":wincmd h<CR>")
vim.keymap.set("", ";j", ":wincmd j<CR>")
vim.keymap.set("", ";k", ":wincmd k<CR>")
vim.keymap.set("", ";l", ":wincmd l<CR>")

vim.keymap.set("", ';"', ":split<CR>")
vim.keymap.set("", ';%', ":vsplit<CR>")
vim.keymap.set("", ';0', ":close<CR>")

vim.keymap.set("", '<Leader>w', ":w<CR>")

vim.keymap.set("n", "<C-w>]", ":rightbelow wincmd ]<CR>")

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

-- Open/close quickfix list
vim.keymap.set("n", "<Space>q", ":cclose<CR>")
vim.keymap.set("n", "<Space>Q", ":botright copen<CR>")

-- Enable/disable diff mode
vim.keymap.set("n", "<Space>dt", ":diffthis<CR>")
vim.keymap.set("n", "<Space>do", ":diffoff<CR>")

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

-- Split windows vertically if there's enough width for two "full size" panes.
-- Otherwise, split horizontally.
vim.api.nvim_create_autocmd('WinNew', {
  callback = function()
    if vim.fn.win_gettype(0) ~= '' then
      return
    end
    if vim.api.nvim_win_get_width(0) > 2 * 80 then
      vim.cmd.wincmd(vim.o.splitright and 'L' or 'H')
    end
  end
})

vim.diagnostic.config({ jump = { float = true } })
