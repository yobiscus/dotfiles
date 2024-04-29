return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.opt.cmdheight = 0;
      vim.api.nvim_create_autocmd({"CmdlineEnter"}, {
        callback = function()
          vim.opt.cmdheight = 1;
        end
      })
      vim.api.nvim_create_autocmd({"CmdlineLeave"}, {
        callback = function()
          vim.opt.cmdheight = 0;
        end
      })
      require("lualine").setup({
        options = { theme = 'gruvbox' },
      })
    end,
}
