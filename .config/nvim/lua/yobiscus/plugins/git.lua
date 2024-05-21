return {
  "https://github.com/tpope/vim-fugitive",
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup()
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = "Toggle Blame" })
    end,
  },
}
