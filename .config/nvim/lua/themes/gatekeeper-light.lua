local M = {}

M.base_30 = {
  white = "#101010", -- Now dark text
  darker_black = "#ffffff", -- Lightest shade (outer bg, etc.)
  black = "#f0f1f4", --  nvim bg
  black2 = "#e6e7eb",
  one_bg = "#dcdee3",
  one_bg2 = "#d2d4da",
  one_bg3 = "#c8cad1",
  grey = "#b1b4bc",
  grey_fg = "#9a9da6",
  grey_fg2 = "#838791",
  light_grey = "#6d717b",
  
  -- Accent colors kept exactly the same
  red = "#ff1a67",
  baby_pink = "#ff86b7",
  pink = "#ff77a8",
  line = "#c8cad1", -- for lines like vertsplit (matches one_bg3)
  green = "#00e756",
  vibrant_green = "#10f766",
  blue = "#29adff",
  nord_blue = "#5c6ab2",
  yellow = "#fff024",
  sun = "#fff82c",
  purple = "#a79ac0",
  dark_purple = "#998cb2",
  teal = "#0b925c",
  orange = "#ffa300",
  cyan = "#29adff",
  statusline_bg = "#e6e7eb",
  lightbg = "#ced0d7",
  pmenu_bg = "#5c6ab2",
  folder_bg = "#29adff",
}

M.base_16 = {
  base00 = "#f0f1f4",
  base01 = "#e6e7eb",
  base02 = "#dcdee3",
  base03 = "#d2d4da",
  base04 = "#c8cad1",
  base05 = "#4a4d57", -- Standard text color (dark grey)
  base06 = "#2d2f36",
  base07 = "#101010",
  -- Terminal colors kept exactly the same
  base08 = "#ffb20f",
  base09 = "#ff004d",
  base0A = "#be620a",
  base0B = "#00e756",
  base0C = "#29adff",
  base0D = "#c54bcf",
  base0E = "#ff4394",
  base0F = "#ffccaa",
}

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.orange },
    ["@variable.parameter"] = { fg = M.base_30.white },
  },
}

M.type = "light"

M = require("base46").override_theme(M, "gatekeeper-light")

return M
