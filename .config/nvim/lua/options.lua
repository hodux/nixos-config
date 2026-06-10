require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

o.scrolloff = 10
o.breakindent = true
o.number = true
o.relativenumber = true
o.confirm = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldcolumn = "1"
o.foldtext = ""
o.foldlevel = 99
o.foldlevelstart = 99


