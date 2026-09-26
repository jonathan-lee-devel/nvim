-- Treesitter-driven indentation for Java. Lives in after/indent so it overrides
-- the built-in indent/java.vim (GetJavaIndent), which loads after ftplugin.
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
