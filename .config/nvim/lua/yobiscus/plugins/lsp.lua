return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'saghen/blink.cmp' },
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- vim.diagnostic.config({ virtual_lines = true })
    vim.diagnostic.config({ virtual_text = true })
    vim.keymap.set('n', '<leader>li', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "toggle inlay hints" })
    vim.lsp.inlay_hint.enable(true)
    vim.keymap.set(
      'n', 'gl', vim.diagnostic.open_float, { desc = "open diagnostic" })

    -- -- Inside a snippet, use backspace to remove the placeholder.
    -- vim.keymap.set('s', '<BS>', '<C-O>s')

    local server_opts = {
      clangd = {},
      lua_la = {},
      rust_analyzer = {
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
      },
    }

    -- augment LSP capabilities with blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local server_handlers = {}
    for server, config in pairs(server_opts) do
        server_handlers[server] = function()
            config.capabilities = capabilities
            lspconfig[server].setup(config)
        end
    end

    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = { 'clangd', 'lua_ls', 'rust_analyzer' },
      handlers = server_handlers
    })
  end
}
