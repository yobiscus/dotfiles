return {
  {
    "zbirenbaum/copilot.lua",
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
          dismiss = '/',
        },
      },
      filetypes = { markdown = true },
    },
    config = function(_, opts)
      local cmp = require 'cmp'
      local copilot = require 'copilot.suggestion'
      local luasnip = require 'luasnip'

      require('copilot').setup(opts)

      local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
      end

      -- Hide suggestions when the completion menu is open.
      cmp.event:on('menu_opened', function()
        if copilot.is_visible() then
          copilot.dismiss()
        end
        set_trigger(false)
      end)

      -- Disable suggestions when inside a snippet.
      cmp.event:on('menu_closed', function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
      end)
      vim.api.nvim_create_autocmd('User', {
        pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
        callback = function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
