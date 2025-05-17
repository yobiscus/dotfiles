return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' },
  },
  config = function()
    vim.diagnostic.config({ virtual_lines = true })
    vim.keymap.set('n', '<leader>li', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "toggle inlay hints" })
    vim.lsp.inlay_hint.enable(true)

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Inside a snippet, use backspace to remove the placeholder.
    vim.keymap.set('s', '<BS>', '<C-O>s')

    cmp.setup({
      -- Disable preselect. On enter, the first thing will be used if nothing
      -- is selected.
      preselect = cmp.PreselectMode.None,
      -- Add icons to the completion menu.
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = require('lspkind').cmp_format({
          mode          = 'symbol',
          maxwidth      = 50,
          ellipsis_char = '...',
          menu          = {
            nvim_lsp = 'λ',
            luasnip = '⋗',
            buffer = 'Ω',
            path = '🖫',
            nvim_lua = 'Π',
          },
          symbol_map    = {
            Copilot = "",
          },
        }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      view = {
        -- Explicitly request documentation.
        docs = { auto_open = false },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          -- select = true,
        },
        -- Explicitly request completions.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Esc>'] = cmp.mapping.close(),
        -- Overload tab to accept Copilot suggestions.
        ['<Tab>'] = cmp.mapping(function(fallback)
          local copilot = require 'copilot.suggestion'

          if copilot.is_visible() then
            copilot.accept()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.expand_or_locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-d>'] = function()
          if cmp.visible_docs() then
            cmp.close_docs()
          else
            cmp.open_docs()
          end
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'crates' },
      }, {
        { name = 'buffer' },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = { 'clangd', 'lua_ls', 'rust_analyzer' },
      handlers = {
        rust_analyzer = function()
          require('lspconfig').rust_analyzer.setup({
            settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                },
                checkOnSave = {
                  command = "clippy",
                },
                inlayHints = {
                  parameterHints = { enable = true },
                  typeHints = { enable = true },
                  implicitDrops = { enable = true },
                },
                procMacro = {
                  ignored = {
                    leptos_macro = {
                      "server",
                    },
                  },
                },
              }
            }
          })
        end,
      },
    })
  end
}
