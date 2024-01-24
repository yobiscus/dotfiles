return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings to learn the available actions
      local opts = { buffer = bufnr }
      lsp_zero.default_keymaps(opts)

      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
      end, opts)

      vim.lsp.inlay_hint.enable(bufnr, true)
    end)

    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {'clangd', 'lua_ls', 'rust_analyzer'},
      handlers = {
        lsp_zero.default_setup,
        rust_analyzer = function()
          require('lspconfig').rust_analyzer.setup({
            settings = {
              ['rust-analyzer'] = {
                inlayHints = {
                  parameterHints = { enable = true },
                  typeHints = { enable = true },
                  implicitDrops = { enable = true },
                },
              }
            }
          })
        end,
      },
    })
  end
}
