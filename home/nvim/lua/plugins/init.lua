return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

 -- indent guides, pairs, autocomplete and more
  { import = "nvchad.blink.lazyspec" },

  -- telescope search
  {
    'nvim-telescope/telescope.nvim', version = '*',
    enabled = false,
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false
  },

  -- tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    -- config = function() ... end
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
  },

  -- faster navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- git interface for neovim
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional
      "m00qek/baleia.nvim",            -- optional
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
  },

  -- detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    lazy = false
  },

  -- auto-save and restore vim sessions
  {
    "folke/persistence.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      -- avoid saving snacks, they create empty buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceSavePre",
        callback = function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft == "snacks_picker_list" or ft == "snacks_layout_box" or ft == "snacks_picker_input" then
              pcall(vim.api.nvim_win_close, win, true)
            end
          end
        end,
      })

      require("persistence").setup(opts)

      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   callback = function()
      --     if vim.fn.argc() == 0 then
      --       require("persistence").load()
      --     end
      --   end,
      --   nested = true,
      -- })
    end,
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session for current dir" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select a Session to restore" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session on exit" },
    },
  },

  -- split or join arrays and objects
  {
    'Wansmer/treesj',
    keys = {
      { '<leader>S', function()
        require('treesj').split()
      end, desc = "Split (TreeSJ)" },
      { '<leader>J', function() require('treesj').join() end, desc = "Join (TreeSJ)" },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        recursive = false,
      })
    end,
  },

  -- highlight todos
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },

  -- preview markdown files
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { "markdown" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render_markdown.Config
    opts = {},
  },

  -- file explorer
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>dt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      focusable = false
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  },

  -- snacks; the best plugin
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- dashboard = { enabled = true },
      bigfile   = { enabled = true },
      notifier  = { enabled = true },
      quickfile = { enabled = true },
      explorer  = { enabled = true, replace_netrw = true },
      terminal  = {
        enabled = true,
        -- win = {
        --   style = "float",
        --   zindex = 150, -- Forces the terminal to pop up over the Zen backdrop
        --   term_normal = false,
        -- }
      },
      words     = { enabled = true },
      scroll    = { enabled = true },
      rename    = { enabled = true },

      input     = { enabled = true },
      scratch   = { enabled = true },
      image     = { enabled = false },
      animate   = { enabled = true },
      zen       = {
        enabled = true,
        toggles = {
          dim = false, -- Disables the dim toggle so the background stays uniformly solid
        },
        win = {
          width = 160,

          backdrop = {
            transparent = false,
          },

        }
      },


      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            win = {
              list = { keys = { ["<c-n>"] = "close" } },
              input = { keys = { ["<c-n>"] = "close" } }
            }
          },
          smart = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
          grep = {
            hidden = true,
            ignored = true,
          },
          recent = {
            hidden = true,
            ignored = true,
          }
        }
      }
    },
    keys = {
      -- explorer
      { "<leader>e", function() Snacks.explorer() end, desc = "Toggle Explorer" },
      { "<c-n>", function() Snacks.explorer() end, desc = "Toggle Explorer" },

      -- picker
      { "<c-p>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep in Files" },

      -- terminal
      { "<c-t>", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },

      -- reference
      { "]]", function() Snacks.words.jump(1, true) end, desc = "Next Reference" },
      { "[[", function() Snacks.words.jump(-1, true) end, desc = "Prev Reference" },

      -- scratchpad
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },

      -- gh
      { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse (Open in Browser)" },
      { "<leader>gh", function() Snacks.picker.gh_issue() end, desc = "Search GitHub Issues" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "Search GitHub PRs" },

      -- zen
      { "<leader>Z", function() Snacks.zen() end, desc = "Toggle Zen Mode"}

    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }
}

