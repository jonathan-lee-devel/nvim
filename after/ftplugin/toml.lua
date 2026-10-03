-- Cargo.toml: crates.nvim keymaps (buffer-local, <leader>c prefix). The plugin
-- shows the newest version of every dependency as virtual text; K hovers a
-- crate and gra offers update / upgrade / open actions through its in-process
-- language server (see plugins/init.lua).
-- <leader>ch (cheatsheet) and <leader>cm (git commits) are NvChad's.
if vim.fn.expand "%:t" ~= "Cargo.toml" then
  return
end

-- crates.nvim loads on BufRead Cargo.toml, after this ftplugin has run, so
-- require it when a key is pressed rather than here.
local function map(mode, lhs, fn, desc)
  vim.keymap.set(mode, lhs, function()
    require("crates")[fn]()
  end, { buffer = true, desc = desc })
end

map("n", "<leader>ct", "toggle", "Crates toggle version hints")
map("n", "<leader>cr", "reload", "Crates reload")

-- Popups
map("n", "<leader>cv", "show_versions_popup", "Crates versions")
map("n", "<leader>cf", "show_features_popup", "Crates features")
map("n", "<leader>cd", "show_dependencies_popup", "Crates dependencies")

-- update = newest version matching the requirement, upgrade = newest overall.
map("n", "<leader>cu", "update_crate", "Crates update crate")
map("x", "<leader>cu", "update_crates", "Crates update selected crates")
map("n", "<leader>ca", "update_all_crates", "Crates update all")
map("n", "<leader>cU", "upgrade_crate", "Crates upgrade crate")
map("x", "<leader>cU", "upgrade_crates", "Crates upgrade selected crates")
map("n", "<leader>cA", "upgrade_all_crates", "Crates upgrade all")

map("n", "<leader>cx", "expand_plain_crate_to_inline_table", "Crates expand to inline table")
map("n", "<leader>cX", "extract_crate_into_table", "Crates extract into table")

map("n", "<leader>cH", "open_homepage", "Crates open homepage")
map("n", "<leader>cR", "open_repository", "Crates open repository")
map("n", "<leader>cD", "open_documentation", "Crates open docs.rs")
map("n", "<leader>cC", "open_crates_io", "Crates open crates.io")
