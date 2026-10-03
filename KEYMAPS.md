# Neovim Keyboard Shortcuts

Generated from this config (NvChad v2.5 base + custom mappings).
`<leader>` is **Space**. `<A-x>` means Alt/Option + x, `<C-x>` means Ctrl + x.

Sources: `lua/mappings.lua`, `lua/configs/lspconfig.lua`, `lua/plugins/init.lua`
(debugger keys), `after/ftplugin/*.lua`, and NvChad's defaults (`nvchad/mappings.lua`, `nvchad/configs/lspconfig.lua`).

Press `<leader>ch` inside Neovim for the interactive NvChad cheatsheet, or
`<leader>wK` to see every keymap via which-key. Using this config on Windows?
See [Windows notes](#windows-notes) at the end.

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
| `grr` | n | Find references / usages of the symbol under the cursor (quickfix list) |
| `gri` | n | Go to implementation |
| `grn` | n | Rename |
| `gra` | n, x | Code action (Rust buffers use rust-analyzer's grouped version, see below) |
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

## Rust

Buffer-local in `.rs` files (`after/ftplugin/rust.lua`) and when
rust-analyzer is attached. Most keys call rustaceanvim's `:RustLsp` command.
Clippy runs on save and reports as diagnostics; rustfmt formats on save.

Running, testing and debugging go through rust-analyzer's runnables, so the
right package, target and test filter are picked for you:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>rr` | n | Run the target under the cursor (`main`, a test, a doctest, ...) |
| `<leader>rR` | n | Pick a runnable from the whole workspace |
| `<leader>rt` | n | Pick a test target |
| `<leader>rT` | n | Rerun the last test target |
| `<leader>rd` | n | Debug the target under the cursor (codelldb) |
| `<leader>rD` | n | Pick a debuggable |
| `<leader>rl` | n | Run the code lens under the cursor (Run / Debug / implementations) |
| `<leader>rb` | n | `cargo build` in a split terminal |

Diagnostics and code:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>re` | n | Show the full rustc diagnostic, as `cargo build` prints it |
| `<leader>rE` | n | Explain the error code under the cursor (`rustc --explain`) |
| `gra` | n, x | Code action with rust-analyzer's grouping (`Import ▶` submenus) |
| `<leader>rh` | n | Hover with actions (press again to enter the window) |
| `<leader>rm` | n | Expand the macro under the cursor recursively |
| `<leader>rj` | n, x | Join lines, fixing up commas, braces and whitespace |
| `<leader>rs` | n, x | Structural search and replace (opens the command line for the pattern) |
| `<leader>ih` | n | Toggle inlay hints (lifetimes, closure return types, binding modes, ...) |

Navigation:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>rp` | n | Go to the parent module |
| `<leader>rc` | n | Open the crate's `Cargo.toml` |
| `<leader>ro` | n | Open docs.rs for the symbol under the cursor |

## Cargo.toml (crates.nvim)

Buffer-local in `Cargo.toml` (`after/ftplugin/toml.lua`). The newest version
of every dependency is shown as virtual text; `K` hovers a crate and `gra`
offers update / upgrade / open actions. "Update" moves to the newest version
that still matches the requirement, "upgrade" to the newest version overall.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cv` | n | Versions popup |
| `<leader>cf` | n | Features popup |
| `<leader>cd` | n | Dependencies popup |
| `<leader>cu` | n, x | Update the crate under the cursor / the selected crates |
| `<leader>ca` | n | Update all crates |
| `<leader>cU` | n, x | Upgrade the crate under the cursor / the selected crates |
| `<leader>cA` | n | Upgrade all crates |
| `<leader>cx` | n | Expand a plain `crate = "1"` entry into an inline table |
| `<leader>cX` | n | Extract the crate into its own `[dependencies.crate]` table |
| `<leader>ct` | n | Toggle the version hints |
| `<leader>cr` | n | Reload crate data |
| `<leader>cH` | n | Open the crate's homepage |
| `<leader>cR` | n | Open the crate's repository |
| `<leader>cD` | n | Open the crate on docs.rs |
| `<leader>cC` | n | Open the crate on crates.io |

## Debugging (DAP)

The session keys are global (`lua/plugins/init.lua`). Sessions start from
the language keys: Go through delve, Rust through codelldb.

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gd` | n | Go: debug the nearest test |
| `<leader>gD` | n | Go: debug the last test again |
| `<leader>rd` | n | Rust: debug the target under the cursor |
| `<leader>rD` | n | Rust: pick a debuggable |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dc` | n | Continue / start |
| `<leader>dn` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step out |
| `<leader>dr` | n | Toggle the DAP REPL |
| `<leader>dq` | n | Terminate the session |

## Folding

Go, Rust, Java, TypeScript and Angular template buffers use treesitter folding
and start fully unfolded. Standard Vim fold keys apply:

| Key | Action |
|-----|--------|
| `za` | Toggle fold under cursor |
| `zc` / `zo` | Close / open fold |
| `zM` / `zR` | Close / open all folds |

## Windows notes

Every keymap above works on Windows. The differences are in what a few of
them run or in what the terminal emulator does before Neovim sees the key.

**Modifier names.** `<A-x>` is the Alt key. `<C-x>` is Ctrl as usual.

**Windows Terminal intercepts `Ctrl+V`.** Its default keybindings map
`ctrl+v` to paste, so `<C-v>` never reaches Neovim. That breaks visual
block mode and the "open in vertical split" key in Telescope and nvim-tree.
Unbind it in Windows Terminal settings (`settings.json` under `"actions"`):

```json
{ "command": "unbound", "keys": "ctrl+v" }
```

`Ctrl+C` is only intercepted while text is selected in the terminal, so
`<C-c>` (copy whole file) works in normal use. Alt combinations
(`<A-h>`, `<A-v>`, `<A-i>`) pass through unchanged.

**Terminals open `cmd.exe`.** `<leader>h`, `<leader>v` and the `<A-...>`
toggles run `'shell'`, which defaults to `cmd.exe` on Windows. `<C-x>`
still leaves terminal mode. To use PowerShell instead, add to
`lua/options.lua`:

```lua
vim.o.shell = "pwsh"
```

**Go test and run keys** (`<leader>gr`, `<leader>gf`, `<leader>gn`,
`<leader>gp`) build a shell command and run it in a split terminal. The
config quotes the package path and the `-run` regex with `shellescape()`,
so they work under both `cmd.exe` and PowerShell, including paths that
contain spaces. On Windows the command runs in `cmd.exe` unless `'shell'`
is changed as above. The Rust run keys (`<leader>rr`, `<leader>rt`,
`<leader>rb`, ...) open their terminal the same way; rustaceanvim builds the
cargo command itself.

**Debugging** (`<leader>gd`, `<leader>gD`, `<leader>d…`) launches delve
through mason's `dlv.cmd` shim. nvim-dap-go runs delve attached on Windows
(it crashes when detached), which the plugin handles by default. Rust
(`<leader>rd`, `<leader>rD`) launches `codelldb.exe` from the mason package
directly. Nothing changes in how the keys behave.

**Clipboard.** `<C-c>` and `"+y` use the win32yank provider that ships
with the Neovim Windows build, so no extra clipboard tool is needed.

**Live grep** (`<leader>fw`) needs ripgrep on PATH, which the README's
winget step installs.
