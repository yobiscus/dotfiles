return {
  "ellisonleao/gruvbox.nvim",
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.opt.termguicolors = true
      require('colorizer').setup()
    end
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        notification = { window = { winblend = 0 } },
        progress = { lsp = { progress_ringbuf_size = 2048 } },
      })
    end
  },
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
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local api = require('dropbar.api')
      vim.keymap.set('n', '<leader>od', api.pick, { desc = "Dropdown UI" })
    end,
  },
  "kmonad/kmonad-vim",
}
