vim.opt.background = 'light'
vim.g.colors_name = 'jdkaplan-warm'

vim.o.termguicolors = true

local pkg = 'jdkaplan.warm_theme'

-- Clear the Lua cache for the theme package to force it to load every time.
package.loaded[pkg] = nil

local lush = require('lush')
local theme = require(pkg)

lush(theme)
