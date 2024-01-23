return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "files" })
      vim.keymap.set('n', '<leader>fi', builtin.git_files, { desc = "git files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help tags" })
    end,
  }
}
