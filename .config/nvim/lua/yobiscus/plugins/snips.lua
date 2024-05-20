return {
  'L3MON4D3/LuaSnip',
  build = "make install_jsregex",
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
