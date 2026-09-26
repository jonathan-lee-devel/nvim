-- TypeScript buffer-local settings (Angular / prettier style: 2-space indent)
local o = vim.opt_local

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true

-- Treesitter-driven folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99 -- start with everything unfolded
