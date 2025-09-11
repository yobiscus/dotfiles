return {
  {
    "banjo/contextfiles.nvim",
    dev = true,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "banjo/contextfiles.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "zbirenbaum/copilot.lua",
    },
    keys = {
      { "<leader>oac", "<cmd>CodeCompanionChat Toggle<cr>", desc="AI Chat" },
      { "<leader>oax", "<cmd>CodeCompanionActions<cr>", desc="AI Actions" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          -- Previously changed copilot to use claude-sonnet-4 by default.
          -- This is now considered a premium model with a request cap, so
          -- leave the default (gpt-4.1) instead.
          -- copilot = function()
          --   return require("codecompanion.adapters").extend("copilot", {
          --     schema = { model = { default = "claude-sonnet-4" } }
          --   })
          -- end,
          -- Default to gpt-5 instead
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = { model = { default = "gpt-5" } }
            })
          end,
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true
            }
          },
          contextfiles = {
            opts = {
              slash_command = {
                ctx_opts = {
                  context_files = { ".github/copilot-instructions.md", },
                  context_dir = ".github/instructions",
                }
              }
            }
          }
        },
        -- display = {
        --   chat = {},
        --   diff = { provider = "mini_diff" },
        -- },
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require('mcphub').setup()
    end,
  },
  -- {
  --   "echasnovski/mini.diff",
  --   config = function()
  --     local diff = require("mini.diff")
  --     diff.setup({
  --       -- Disabled by default
  --       source = diff.gen_source.none(),
  --     })
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false },
      suggestion = {
        keymap = {
          -- Disable the built-in mapping, we'll configure it in nvim-cmp.
          accept = false,
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<Esc>',
        },
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        yaml = true,
      },
    },
  },
}
