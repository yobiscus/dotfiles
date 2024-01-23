return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        mappings = false,
      })

      vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment'})
      vim.keymap.set('v', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment'})
    end,
  },
}
