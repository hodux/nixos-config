require("nvchad.configs.telescope")

require("telescope").setup({
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--no-ignore", "-g", "!.git" },
    },
  },
})
