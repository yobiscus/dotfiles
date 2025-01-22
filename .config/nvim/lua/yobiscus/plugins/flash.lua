return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    local flash = require("flash")
    vim.keymap.set({'n', 'x', 'o'}, '<leader>s', function() flash.jump() end, { desc = "Flash" })
    vim.keymap.set({'n', 'x', 'o'}, '<leader>S', function() flash.treesitter() end, { desc = "Flash Treesitter" })
    vim.keymap.set('o', 'r', function() flash.remote() end, { desc = "Remote Flash" })
    vim.keymap.set({'o', 'x'}, 'R', function() flash.treesitter_search() end, { desc = "Treesitter Search" })
  end
}
