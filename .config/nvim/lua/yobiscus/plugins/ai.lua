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
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc="AI Chat" },
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", desc="AI Actions" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            -- Use Claude Sonnet 4 (premium) as default
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {
                schema = { model = { default = "claude-sonnet-4.5" } }
              })
            end,
            -- Use GPT-5 (premium) as default
            -- copilot = function()
            --   return require("codecompanion.adapters").extend("copilot", {
            --     schema = { model = { default = "gpt-5" } }
            --   })
            -- end,
          }
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
        display = {
          chat = {
            -- auto_scroll = false,
            window = {
              layout = "float",
            },
          },
        --   diff = { provider = "mini_diff" },
        },
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
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      -- instructions_file = "avante.md",
      instructions_file = ".github/copilot-instructions.md",
      -- for example
      provider = "copilot",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
  }
}
