-- vim settings
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"
vim.opt.relativenumber = true
vim.opt.clipboard = nil

-- misc lvim settings
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "gruvbox-material"
lvim.builtin.project.silent_chdir = false
-- lvim.builtin.dap.active = true

-- gui settings
vim.opt.guifont = "MesloLGS NF:h10"
-- vim.g.neovide_fullscreen = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.term_mode["<Esc><Esc>"] = "<C-\\><C-n>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.terminal.active = true
lvim.builtin.terminal.execs = {}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- rust LSP settings
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
-- html/css LSP settings
require("lvim.lsp.manager").setup("emmet_ls")
require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = { "rust" },
  init_options = {
    userLanguages = {
      rust = "html",
    },
  }
})

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
}

-- Additional Plugins
lvim.plugins = {
  { "sainnhe/gruvbox-material" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
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
    "ray-x/lsp_signature.nvim",
    event = "bufread",
    config = function()
      require "lsp_signature".on_attach()
    end
  },
  {
    "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" },
    config = function()
      require("rust-tools").setup {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = require("lvim.lsp").common_on_attach,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                allTargets = true,
                features = "all",
                -- command = "cargo clippy --workspace --message-format=json --all-targets --all-features"
              },
            },
          },
        },
      }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
  },
}
