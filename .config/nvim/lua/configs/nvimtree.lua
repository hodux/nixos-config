require("nvchad.configs.nvimtree")

require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  renderer = {
    highlight_git = true,
  },
  git = {
    ignore = false,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
  },
})
