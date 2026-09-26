require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Angular: jump between a component's sibling files
-- (foo.component.ts / .html / .scss|.css / .spec.ts)
local function angular_sibling(ext)
  return function()
    local file = vim.api.nvim_buf_get_name(0)
    local base = file:match "^(.-)%.spec%.ts$" or file:match "^(.-)%.[%w]+$"
    if not base then
      return
    end
    local candidates = ext == "style" and { base .. ".scss", base .. ".css", base .. ".sass", base .. ".less" }
      or { base .. "." .. ext }
    for _, path in ipairs(candidates) do
      if vim.uv.fs_stat(path) then
        vim.cmd.edit(vim.fn.fnameescape(path))
        return
      end
    end
    vim.notify("No " .. ext .. " file for this component", vim.log.levels.WARN)
  end
end

map("n", "<leader>at", angular_sibling "ts", { desc = "Angular component class" })
map("n", "<leader>ah", angular_sibling "html", { desc = "Angular component template" })
map("n", "<leader>as", angular_sibling "style", { desc = "Angular component styles" })
map("n", "<leader>ae", angular_sibling "spec.ts", { desc = "Angular component spec" })
