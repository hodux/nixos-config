if not vim.g.vscode then
  require "nvchad.mappings"
end

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- snacks picker
map("n", "<leader>ff", function() Snacks.picker.smart() end, { desc = "Find Files" })
map("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Find Word" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Search Recent Files" })
map("n", "<leader>fz", function() Snacks.picker.zoxide() end, { desc = "Zoxide (Recent Projects)" })

-- snacks explorer
map("n", "<C-n>", function() Snacks.explorer() end, { desc = "Toggle Snacks Explorer" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Focus Snacks Explorer" })

-- oil
map("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Open File Explorer" })

-- lsp
map("n", "<leader>df", vim.diagnostic.open_float, { desc = "LSP floating diagnostic" })
map("n", "<leader>da", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- save with ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- toggle whitespaces
map('n', '<leader>ui', function()
  vim.wo.list = not vim.wo.list
  print("invisible characters: " .. (vim.wo.list and "On" or "Off"))
end, { desc = 'toggle invisibles' })

-- clipboard shortcuts
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
pcall(vim.keymap.del, "n", "<leader>pt")
