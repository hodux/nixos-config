-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function send_osc(code)
  if vim.env.TMUX then
    code = string.format("\027Ptmux;\027%s\027\\", code:gsub("\027", "\027\027"))
  end
  io.stdout:write(code)
  io.stdout:flush()
end

local function set_terminal_bg()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if not normal or not normal.bg then
    return
  end
  local hex = string.format("#%06x", normal.bg)
  send_osc(string.format("\027]11;%s\027\\", hex))
end

local function reset_terminal_bg()
  send_osc("\027]111\027\\")
end

set_terminal_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_terminal_bg,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimLeavePre" }, {
  callback = reset_terminal_bg,
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
  desc = "Auto save buffer on focus lost, buffer leave, or leaving insert mode",
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].modified and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent! write")
      end)
    end
  end,
})
