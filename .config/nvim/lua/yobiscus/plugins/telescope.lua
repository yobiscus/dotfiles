return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "files" })
      vim.keymap.set('n', '<leader>fi', builtin.git_files, { desc = "git files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help tags" })
      require('telescope').setup({})
      require('telescope').load_extension('fzf')
    end,
  }
}
