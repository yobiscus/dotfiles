return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local luasnip = require 'luasnip'
    local types = require 'luasnip.util.types'

    require("luasnip.loaders.from_vscode").lazy_load()

    -- HACK: Cancel the snippet session when leaving insert mode.
    vim.api.nvim_create_autocmd('ModeChanged', {
      group = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange', { clear = true }),
      pattern = { 's:n', 'i:*' },
      callback = function(event)
        if
          luasnip.session
          and luasnip.session.current_nodes[event.buf]
          and not luasnip.session.jump_active
        then
          luasnip.unlink_current()
        end
      end,
    })

    luasnip.setup {
      -- Display a cursor-like placeholder in unvisited nodes
      -- of the snippet.
      ext_opts = {
        [types.insertNode] = {
          unvisited = {
            virt_text = { { '|', 'Conceal' } },
            virt_text_pos = 'inline',
          },
        },
        [types.exitNode] = {
          unvisited = {
            virt_text = { { '|', 'Conceal' } },
            virt_text_pos = 'inline',
          },
        },
      },
    }
  end,
}
