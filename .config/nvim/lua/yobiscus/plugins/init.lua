return {
  "sainnhe/gruvbox-material",
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.cmd [[
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
        nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
        nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
        nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
        let g:tmux_navigator_disable_when_zoomed = 1
      ]]
    end
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { desc = "Undotree" })
    end,
  },
}
