return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = { "vale" },
      rst = { "vale" },
      yaml = { "yamllint" },
      -- python = { "pylint", "mypy" },
    }

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        require("lint").try_lint()
      end,
    })
    vim.api.nvim_create_user_command("LinterInfo", function()
      local runningLinters = table.concat(require("lint").get_running(), "\n")
      vim.notify(runningLinters, vim.log.levels.INFO, { title = "nvim-lint" })
    end, {})
  end,
}
