return {
  {
    "folke/which-key.nvim",
    dependencies = {
      'echasnovski/mini.nvim',
    },
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      -- <leader> groups
      wk.add({
        { "<leader>e", group = "extension" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>o", group = "open" },
        { "<leader>oa", group = "AI" },
        { "<leader>x", group = "trouble" },
      })
    end
  },
}
