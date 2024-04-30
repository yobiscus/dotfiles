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
vim.opt.shell = "/bin/bash" -- fish shell for example is much slower

-- keymaps
vim.keymap.set('n', '<leader>on', '<cmd>Ex<cr>', { desc = 'Netrw' })
vim.keymap.set('n', '<leader>oc', function()
  vim.cmd('lcd ~/.config/nvim')
  vim.cmd('e lua/yobiscus/init.lua')
end, { desc = 'Neovim config' })

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- plugins
require("yobiscus.lazy")
