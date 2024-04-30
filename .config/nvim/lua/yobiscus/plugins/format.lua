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
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      markdown = { "markdown-toc" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
    },
  }
}
