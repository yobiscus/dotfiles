return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set('n', '<leader>oa', mark.add_file, { desc = "Harpoon file" })
    vim.keymap.set('n', '<leader>oh', ui.toggle_quick_menu, { desc = "Harpoon list" })

    -- optimized for colemak keybind even though I am on qwerty
    vim.keymap.set('n', '<leader>oq', function() ui.nav_file(1) end, { desc = "Harpoon file 1" }) -- netrw hijacks this, what to do?
    -- vim.keymap.set('n', '<C-n>', function() ui.nav_file(2) end)
    vim.keymap.set('n', '<leader>ow', function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
  end
}
