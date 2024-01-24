return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
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

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local has_words_before = function()
      if vim.api.nvim_get_option_value("buftype", {}) == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end
    cmp.setup({
      formatting = lsp_zero.cmp_format(),
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      }),
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
