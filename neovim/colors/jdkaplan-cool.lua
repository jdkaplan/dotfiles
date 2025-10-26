vim.opt.background = "dark"
vim.g.colors_name = "jdkaplan-cool"

vim.o.termguicolors = true

local pkg = "jdkaplan.cool_theme"

-- Clear the Lua cache for the theme package to force it to load every time.
package.loaded[pkg] = nil

local lush = require("lush")
local theme = require(pkg)

lush(theme)
