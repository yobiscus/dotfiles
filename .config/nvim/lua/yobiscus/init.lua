vim.g.mapleader = " "

-- settings
vim.opt.mouse = ""
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣', extends = '>', precedes = '<' }

-- keymaps
vim.keymap.set('n', '<leader>on', '<cmd>Ex<cr>', { desc = 'Netrw' })
vim.keymap.set('n', '<leader>oc', function()
  vim.cmd('lcd ~/.config/nvim')
  vim.cmd('e lua/yobiscus/init.lua')
end, { desc = 'Neovim config' })

-- plugins
require("yobiscus.lazy")
