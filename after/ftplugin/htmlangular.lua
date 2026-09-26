-- Angular template buffer-local settings (Neovim's own ftplugin/htmlangular.vim
-- already sources the html one; this only adds indentation and folding).
local o = vim.opt_local

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true

-- Treesitter-driven folding via the `angular` parser
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
