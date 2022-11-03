-- load from friendly-snippets plugin
local vs_path = vim.fn.stdpath('data')..'/site/pack/packer/start/friendly-snippets/'
local my_path = vim.fn.stdpath('config')..'/snippets/'

require("luasnip.loaders.from_vscode").load({
  paths=vs_path,
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = { my_path }
})
