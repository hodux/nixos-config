-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  transparency = true,
  theme = "flexoki-light",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = {
  load_on_startup = true,

  buttons = {
    -- Now does the exact same thing as your Ctrl+P (Searches files, recent, and buffers)
    { txt = "  Find File", keys = "ff", cmd = "lua Snacks.picker.smart()" },
    { txt = "  Recent Files", keys = "fr", cmd = "lua Snacks.picker.recent()" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "lua Snacks.picker.grep()" },
    { txt = "  Browse Files (oil)", keys = "fo", cmd = "Oil" },
    { txt = "  Find Project", keys = "fz", cmd = "lua Snacks.picker.zoxide()" },

    { txt = "󱥚  Themes", keys = "th", cmd = "lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "  Show Neogit", keys = "gg", cmd = "Neogit" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {
  tabufline = {
    modules = {
      treeOffset = function()
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype

        if ft == "NvimTree" or ft == "snacks_layout_box" or ft == "snacks_picker_list" then
          local width = vim.api.nvim_win_get_width(win)

          -- the cool stuff
          local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          local title = " 󰙅  Explorer" ..  " | 󰉖 " .. project

          local pad_width = width - vim.fn.strdisplaywidth(title)
          local padding = string.rep(" ", pad_width > 0 and pad_width or 0)

          return "%#NvimTreeNormal#" .. title .. padding
        end

        return ""
      end,
    },
  },
}

return M
