return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = 'n',
      desc = 'format buffer',
    },
  },
  opts = {
    format_on_save = true,
    formatters_by_ft = {
      css = { 'prettier' },
      html = { 'prettier' },
      htmldjango = { 'prettier' },
      json = { 'jq' },
      jsonc = { 'jq' },
      lua = { 'stylua' },
      markdown = { "markdown-toc" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      rust = { "rustfmt", "leptosfmt", lsp_format = "fallback" },
    },
  }
}
