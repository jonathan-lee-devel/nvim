require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Font for GUI clients (Neovide, VimR, etc.); terminal Neovim ignores this
-- and uses the terminal's font (Ghostty is also set to SauceCodePro).
-- Only the SemiBold face is installed, so the family resolves to that weight.
vim.o.guifont = "SauceCodePro Nerd Font:h14"

-- Angular templates: Neovim only detects `htmlangular` by sniffing the first
-- 40 lines for Angular syntax, so a fresh/plain *.component.html would be
-- treated as plain html. Match on the file name too (used by the angular
-- treesitter parser, angularls, html-lsp and prettier).
vim.filetype.add {
  extension = {
    -- Go text/template & html/template files (gotmpl treesitter parser, gopls).
    gotmpl = "gotmpl",
    gohtml = "gotmpl",
    tmpl = "gotmpl",
  },
  pattern = {
    [".*%.component%.html"] = "htmlangular",
  },
}
