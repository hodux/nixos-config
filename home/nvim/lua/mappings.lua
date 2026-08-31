if not vim.g.vscode then
  require "nvchad.mappings"
end

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

if vim.g.vscode then
  local vscode_action = function(cmd)
    local ok, vscode = pcall(require, "vscode")
    if ok and vscode then
      vscode.action(cmd)
    else
      vim.fn.VSCodeNotify(cmd)
    end
  end

  -- file picker keymaps (VS Code native search)
  map("n", "<leader>ff", function() vscode_action "workbench.action.quickOpen" end, { desc = "Find Files (VS Code Quick Open)" })
  map("n", "<leader>fw", function() vscode_action "workbench.action.findInFiles" end, { desc = "Find Word (VS Code Find in Files)" })
  map("n", "<leader>fr", function() vscode_action "workbench.action.openRecent" end, { desc = "Search Recent Files (VS Code Open Recent)" })
  map("n", "<leader>fp", function() vscode_action "workbench.action.files.openFolder" end, { desc = "Open Folder (VS Code)" })

  -- file explorer
  map("n", "<leader>e", function() vscode_action "workbench.files.action.showActiveFileInExplorer" end, { desc = "Reveal Active File in Explorer (VS Code)" })

  -- pane / window navigation
  local focus_left = function() vscode_action "workbench.action.navigateLeft" end
  local focus_right = function() vscode_action "workbench.action.navigateRight" end
  local focus_down = function() vscode_action "workbench.action.navigateDown" end
  local focus_up = function() vscode_action "workbench.action.navigateUp" end

  map("n", "<leader>h", focus_left, { desc = "Focus Left Pane" })
  map("n", "<leader>l", focus_right, { desc = "Focus Right Pane" })
  map("n", "<leader>j", focus_down, { desc = "Focus Down Pane" })
  map("n", "<leader>k", focus_up, { desc = "Focus Up Pane" })

  map("n", "<C-h>", focus_left, { desc = "Focus Left Pane" })
  map("n", "<C-l>", focus_right, { desc = "Focus Right Pane" })
  map("n", "<C-j>", focus_down, { desc = "Focus Down Pane" })
  map("n", "<C-k>", focus_up, { desc = "Focus Up Pane" })

  map("n", "<C-w>h", focus_left, { desc = "Focus Left Pane" })
  map("n", "<C-w>l", focus_right, { desc = "Focus Right Pane" })
  map("n", "<C-w>j", focus_down, { desc = "Focus Down Pane" })
  map("n", "<C-w>k", focus_up, { desc = "Focus Up Pane" })

  -- tab navigation & closing
  map("n", "<Tab>", function() vscode_action "workbench.action.nextEditor" end, { desc = "Next Tab / Editor" })
  map("n", "<S-Tab>", function() vscode_action "workbench.action.previousEditor" end, { desc = "Previous Tab / Editor" })
  map("n", "<leader>x", function() vscode_action "workbench.action.closeActiveEditor" end, { desc = "Close Current Tab / Editor" })

  -- lsp
  map("n", "<leader>df", function() vscode_action "editor.action.showHover" end, { desc = "LSP floating diagnostic / Hover" })
  map("n", "<leader>da", function() vscode_action "editor.action.quickFix" end, { desc = "LSP code action" })

  -- gx for VS Code
  map({ "n", "v" }, "gx", function() vscode_action "editor.action.openLink" end, { desc = "Open Link (VS Code)" })
else
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

  -- gf and gx for standalone Neovim
  map({ "n", "v" }, "gx", function()
    local file = vim.fn.expand "<cfile>"
    if file and file ~= "" then
      vim.ui.open(file)
    end
  end, { desc = "Open Link / File under cursor" })
end

-- save with ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- toggle whitespaces
map("n", "<leader>ui", function()
  vim.wo.list = not vim.wo.list
  print("invisible characters: " .. (vim.wo.list and "On" or "Off"))
end, { desc = "toggle invisibles" })

-- clipboard shortcuts
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
pcall(vim.keymap.del, "n", "<leader>pt")
