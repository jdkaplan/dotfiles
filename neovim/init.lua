vim.o.shell = "/bin/sh"
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
  },
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
vim.keymap.set("", "<Space>w%", ":vsplit<CR>")

vim.keymap.set("", "<Leader>w", ":w<CR>")

vim.keymap.set("n", "<C-w>]", function()
  if vim.api.nvim_win_get_width(0) > 2 * 80 then
    vim.cmd("vertical wincmd ]")
  else
    vim.cmd("horizontal wincmd ]")
  end
end)

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ";w", ":w<CR>")

-- TODO: Delete these ; fake-leader bindings
vim.keymap.set("", ";;", ";")

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

vim.diagnostic.config({ jump = { float = true } })

function auto_correct(mode, old, new, scale, limit, cmd)
  delay = scale

  vim.keymap.set(mode, old, function()
    vim.print("You should use " .. new)
    vim.cmd.sleep(delay .. "m")
    cmd()
    delay = math.min(delay + scale, limit)
  end)
end

auto_correct("n", ';"', "<C-w>s", 100, 1000, vim.cmd.split)
auto_correct("n", ";%", "<C-w>v", 100, 1000, vim.cmd.vsplit)
auto_correct("n", ";0", "<C-w>c", 100, 1000, vim.cmd.close)
auto_correct("n", ";h", "<C-w>h", 10, 500, function()
  vim.cmd.wincmd("h")
end)
auto_correct("n", ";j", "<C-w>j", 10, 500, function()
  vim.cmd.wincmd("j")
end)
auto_correct("n", ";k", "<C-w>k", 10, 500, function()
  vim.cmd.wincmd("k")
end)
auto_correct("n", ";l", "<C-w>l", 10, 500, function()
  vim.cmd.wincmd("l")
end)
