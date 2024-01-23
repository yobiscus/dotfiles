vim.g.mapleader = " "

-- settings
vim.opt.undofile = true

-- keymaps
vim.keymap.set('n', '<leader>on', '<cmd>Ex<cr>', { desc = 'Netrw' })

-- plugins
require("yobiscus.lazy")
