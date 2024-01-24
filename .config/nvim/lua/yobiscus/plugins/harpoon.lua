return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', '<C-s>', ui.toggle_quick_menu)

    -- optimized for colemak keybind even though I am on qwerty
    vim.keymap.set('n', '<C-m>', function() ui.nav_file(1) end) -- netrw hijacks this, what to do?
    -- vim.keymap.set('n', '<C-n>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<C-e>', function() ui.nav_file(2) end)
  end
}
