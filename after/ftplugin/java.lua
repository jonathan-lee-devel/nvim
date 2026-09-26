-- Java buffer-local settings (google-java-format style: 2-space indent, 100 cols)
local o = vim.opt_local

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.colorcolumn = "100"

-- Treesitter-driven folding (indentexpr is set in after/indent/java.lua)
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99 -- start with everything unfolded
