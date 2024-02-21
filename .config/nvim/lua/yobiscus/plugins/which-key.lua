return {
  {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    keys = { "<leader>", '"' },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      -- <leader> groups
      wk.register({
        f = { desc = "Find" },
        l = { desc = "LSP" },
        o = { desc = "Open" },
        x = { desc = "Trouble" },
      }, { prefix = "<leader>" })
    end
  },
}
