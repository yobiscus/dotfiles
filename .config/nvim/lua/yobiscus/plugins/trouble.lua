return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Toggle" })
    vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "WS diags" })
    vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "Doc diags" })
    vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Loclist" })
    vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "Lsp diag" })
  end
}
