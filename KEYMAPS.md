# Neovim Keyboard Shortcuts

Generated from this config (NvChad v2.5 base + custom mappings).
`<leader>` is **Space**. `<A-x>` means Alt/Option + x, `<C-x>` means Ctrl + x.

Sources: `lua/mappings.lua`, `lua/configs/lspconfig.lua`, `after/ftplugin/*.lua`,
and NvChad's defaults (`nvchad/mappings.lua`, `nvchad/configs/lspconfig.lua`).

Press `<leader>ch` inside Neovim for the interactive NvChad cheatsheet, or
`<leader>wK` to see every keymap via which-key.

---

## File explorer (nvim-tree)

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` | n | Toggle the file explorer |
| `<leader>e` | n | Focus the file explorer |

Inside the explorer (nvim-tree defaults):

| Key | Action |
|-----|--------|
| `Enter` / `o` | Open file or expand folder |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `a` | Create file (end with `/` for a folder) |
| `r` | Rename |
| `d` | Delete |
| `x` / `c` / `p` | Cut / copy / paste |
| `y` | Copy file name |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |
| `H` | Toggle dotfiles |
| `I` | Toggle gitignored files |
| `R` | Refresh |
| `-` | Go up to parent directory |
| `<C-]>` | Change root to folder under cursor |
| `q` | Close the explorer |
| `g?` | Show all nvim-tree keymaps |

## Finding things (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fa` | n | Find all files (including hidden and ignored) |
| `<leader>fw` | n | Live grep across the project |
| `<leader>fz` | n | Fuzzy find in the current buffer |
| `<leader>fb` | n | List open buffers |
| `<leader>fo` | n | Recently opened files |
| `<leader>fh` | n | Search help tags |
| `<leader>ma` | n | List marks |
| `<leader>cm` | n | Git commits |
| `<leader>gt` | n | Git status |
| `<leader>pt` | n | Pick a hidden terminal |
| `<leader>th` | n | Theme picker |

Inside a Telescope picker: `<C-j>` / `<C-k>` or `<Down>` / `<Up>` move,
`Enter` opens, `<C-v>` / `<C-x>` open in vertical / horizontal split,
`Esc` then `q` closes.

## General editing

| Key | Mode | Action |
|-----|------|--------|
| `;` | n | Enter command mode (same as `:`) |
| `jk` | i | Leave insert mode (same as `Esc`) |
| `<C-s>` | n | Save file |
| `<C-c>` | n | Copy the whole file to the system clipboard |
| `Esc` | n | Clear search highlights |
| `<leader>/` | n, v | Toggle comment on line or selection |
| `<leader>fm` | n, x | Format file or selection (conform, LSP fallback) |
| `<leader>n` | n | Toggle line numbers |
| `<leader>rn` | n | Toggle relative line numbers |
| `<leader>ch` | n | Open the NvChad cheatsheet |
| `<leader>wK` | n | Show all keymaps (which-key) |
| `<leader>wk` | n | Look up a keymap prefix (which-key) |

Insert mode cursor movement:

| Key | Action |
|-----|--------|
| `<C-b>` | Jump to beginning of line |
| `<C-e>` | Jump to end of line |
| `<C-h>` / `<C-l>` | Move left / right |
| `<C-j>` / `<C-k>` | Move down / up |

## Windows, buffers and tabs

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | n | Move focus to the window left / down / up / right |
| `Tab` | n | Next buffer |
| `Shift-Tab` | n | Previous buffer |
| `<leader>b` | n | New empty buffer |
| `<leader>x` | n | Close current buffer |

## Terminal

| Key | Mode | Action |
|-----|------|--------|
| `<leader>h` | n | New horizontal terminal |
| `<leader>v` | n | New vertical terminal |
| `<A-h>` | n, t | Toggle a horizontal terminal |
| `<A-v>` | n, t | Toggle a vertical terminal |
| `<A-i>` | n, t | Toggle a floating terminal |
| `<C-x>` | t | Leave terminal mode (back to normal mode) |

## LSP (any language)

Available once a language server attaches to the buffer.

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `<leader>D` | n | Go to type definition |
| `<leader>ra` | n | Rename symbol |
| `<leader>ds` | n | Diagnostics in the location list |
| `<leader>ih` | n | Toggle inlay hints |
| `<leader>wa` | n | Add workspace folder |
| `<leader>wr` | n | Remove workspace folder |
| `<leader>wl` | n | List workspace folders |

Neovim 0.11 built-in LSP maps (not defined in this config, but active):

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `grr` | n | References |
| `gri` | n | Go to implementation |
| `grn` | n | Rename |
| `gra` | n, x | Code action |
| `gO` | n | Document symbols |
| `[d` / `]d` | n | Previous / next diagnostic |
| `<C-s>` | i | Signature help |
| `<C-x><C-o>` | i | Trigger LSP completion |

## Angular

Jump between the sibling files of the current component
(`foo.component.ts` / `.html` / `.scss` / `.spec.ts`).

| Key | Mode | Action |
|-----|------|--------|
| `<leader>at` | n | Open the component class (`.ts`) |
| `<leader>ah` | n | Open the component template (`.html`) |
| `<leader>as` | n | Open the component styles (`.scss` / `.css` / `.sass` / `.less`) |
| `<leader>ae` | n | Open the component spec (`.spec.ts`) |

## TypeScript / JavaScript

Buffer-local, when vtsls or eslint is attached.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>to` | n | Organize imports |
| `<leader>ta` | n | Add missing imports |
| `<leader>tu` | n | Remove unused imports |
| `<leader>tf` | n | Fix all (TypeScript) |
| `<leader>ts` | n | Go to source definition (skips `.d.ts`) |
| `<leader>te` | n | ESLint fix all |

## Java

Buffer-local, when jdtls is attached.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>jo` | n | Organize imports |

## Go

Buffer-local in `.go` files (`after/ftplugin/go.lua`) and when gopls is attached.

Navigation and running:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ga` | n | Toggle between `foo.go` and `foo_test.go` |
| `<leader>gr` | n | `go run` the current package (split terminal) |
| `<leader>gl` | n | Run the code lens under the cursor (test / generate / tidy) |
| `<leader>go` | n | Organize imports |
| `<leader>gm` | n | `go mod tidy` (also available in `go.mod` buffers) |
| `<leader>gv` | n | Run govulncheck |

Tests:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gn` | n | Run the nearest test function |
| `<leader>gf` | n | Test the current package |
| `<leader>gp` | n | Test the whole package tree (`go test ./...`) |
| `<leader>gG` | n | Generate a test for the function under the cursor |
| `<leader>gA` | n | Generate tests for the whole file |

Code generation (gopher.nvim):

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gj` | n | Add `json` struct tags |
| `<leader>gy` | n | Add `yaml` struct tags |
| `<leader>gx` | n | Remove struct tags |
| `<leader>ge` | n | Insert `if err != nil` block |
| `<leader>gi` | n | Implement an interface (`:GoImpl recv iface`) |

## Debugging (DAP)

Defined in Go buffers. Delve is launched through nvim-dap-go.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gd` | n | Debug the nearest test |
| `<leader>gD` | n | Debug the last test again |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dc` | n | Continue / start |
| `<leader>dn` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step out |
| `<leader>dr` | n | Toggle the DAP REPL |
| `<leader>dq` | n | Terminate the session |

## Folding

Go, Java, TypeScript and Angular template buffers use treesitter folding and
start fully unfolded. Standard Vim fold keys apply:

| Key | Action |
|-----|--------|
| `za` | Toggle fold under cursor |
| `zc` / `zo` | Close / open fold |
| `zM` / `zR` | Close / open all folds |
