return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local fzf_lua = require('fzf-lua')
    vim.keymap.set('n', '<leader>ff', fzf_lua.files, { desc = "files" })
    vim.keymap.set('n', '<leader>fi', fzf_lua.git_files, { desc = "git files" })
    vim.keymap.set('n', '<leader>fg', fzf_lua.live_grep, { desc = "grep" })
    vim.keymap.set('n', '<leader>fa', fzf_lua.args, { desc = "args" })
    vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, { desc = "buffers" })
    vim.keymap.set('n', '<leader>fh', fzf_lua.helptags, { desc = "help tags" })
    vim.keymap.set('n', '<leader>fl', fzf_lua.lsp_finder, { desc = "lsp" })
    fzf_lua.setup({})
  end,
}
