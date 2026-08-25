-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Same "Find Files (Root Dir)" picker as <leader><space> (Space Space).
vim.keymap.set("n", "<C-p>", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })

-- Toggle the neo-tree sidebar. Bound to Ctrl+K/Ctrl+B since Hyprland forwards
-- SUPER+K and SUPER+B as Ctrl+K/Ctrl+B to the focused window (bindings.lua).
local function toggle_neotree()
  require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
end
vim.keymap.set("n", "<C-k>", toggle_neotree, { desc = "Toggle Explorer NeoTree" })
vim.keymap.set("n", "<C-b>", toggle_neotree, { desc = "Toggle Explorer NeoTree" })

-- Cycle between window panes.
vim.keymap.set("n", "<C-Left>", "<C-w>W", { desc = "Cycle to previous pane" })
vim.keymap.set("n", "<C-Right>", "<C-w>w", { desc = "Cycle to next pane" })

-- Ctrl+[ / Ctrl+] also cycle panes. Ghostty used to claim these for its own
-- split navigation (config/ghostty: ctrl+[/ctrl+]=goto_split:previous/next),
-- so they never reached Neovim - freed there (alt+[/alt+] and super+[/super+]
-- already cover the same Ghostty action) so they land here instead. This
-- shadows Vim's builtin <C-]> tag-jump - not used in this LSP-based setup.
vim.keymap.set("n", "<C-[>", "<C-w>W", { desc = "Cycle to previous pane" })
vim.keymap.set("n", "<C-]>", "<C-w>w", { desc = "Cycle to next pane" })

-- Alt+D / Alt+Shift+D for vertical/horizontal splits. Not Ctrl+D: that's
-- Neovim's default "scroll down half page". Not Super+D: Ghostty and
-- Hyprland already use that for the terminal's own native split
-- (bindings.lua leaves SUPER+D unbound for this reason).
vim.keymap.set("n", "<A-d>", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "<A-S-d>", "<C-w>s", { desc = "Horizontal split" })

-- Alt+W closes the current split/pane.
vim.keymap.set("n", "<A-w>", "<C-w>c", { desc = "Close split" })

-- Alt+[ / Alt+] cycle between open splits.
vim.keymap.set("n", "<A-[>", "<C-w>W", { desc = "Cycle to previous pane" })
vim.keymap.set("n", "<A-]>", "<C-w>w", { desc = "Cycle to next pane" })

-- Tab / Shift+Tab cycle buffers, same as LazyVim's default <S-h>/<S-l>.
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- t then n/p cycle vim tabs (tabpages), not to be confused with buffers above.
vim.keymap.set("n", "tn", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "tp", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })

-- t then t opens a new tab.
vim.keymap.set("n", "tt", "<cmd>tabnew<cr>", { desc = "New Tab" })

-- t then w closes the current tab (w = close, same convention as <A-w> for splits).
vim.keymap.set("n", "tw", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Ctrl+E / Ctrl+Y scroll 10 lines instead of the default 1.
vim.keymap.set("n", "<C-e>", "10<C-e>", { desc = "Scroll down 10 lines" })
vim.keymap.set("n", "<C-y>", "10<C-y>", { desc = "Scroll up 10 lines" })

-- Neovide-only: Ctrl+Tab / Ctrl+1..9 ride on keys a terminal (and Ghostty's
-- own tab keybinds) would intercept before Neovim ever sees them, so they
-- only make sense for the GUI, where Neovide gets the raw key event.
if vim.g.neovide then
  vim.keymap.set("n", "<C-Tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
  vim.keymap.set("n", "<C-S-Tab>", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
  for i = 1, 8 do
    vim.keymap.set("n", "<C-" .. i .. ">", "<cmd>tabnext " .. i .. "<cr>", { desc = "Go to Tab " .. i })
  end
  vim.keymap.set("n", "<C-9>", "<cmd>tablast<cr>", { desc = "Go to Last Tab" })
end

-- Ctrl+O: Sublime-style command palette (fuzzy list of all Ex commands).
vim.keymap.set("n", "<C-o>", function() Snacks.picker.commands() end, { desc = "Command Palette" })

-- <leader>p: jumps straight to the project picker, one Enter instead of the
-- two the command palette above needs (pick "OpenProject", then pick the
-- project). NOT <leader>fp - that's already "Find Plugin File" (example.lua).
vim.keymap.set("n", "<leader>p", function() Snacks.picker.projects() end, { desc = "Open Project" })

-- Registered so "Open Project" (this command) actually shows up when
-- searching the command palette above - Snacks.picker.projects() has no
-- Ex command of its own otherwise.
vim.api.nvim_create_user_command("OpenProject", function()
  Snacks.picker.projects()
end, { desc = "Open Project" })

local function build_cmd()
  local root = LazyVim.root()
  return { "bash", root .. "/build.sh" }, root
end

local function run_build()
  local cmd, root = build_cmd()
  if vim.fn.filereadable(cmd[2]) == 0 then
    vim.notify("No build.sh in " .. root, vim.log.levels.WARN)
    return
  end
  local existing = Snacks.terminal.get(cmd, { cwd = root, create = false })
  if existing then
    local job = vim.b[existing.buf].terminal_job_id
    if job and vim.fn.jobwait({ job }, 0)[1] == -1 then
      vim.notify("Build already running", vim.log.levels.WARN)
      existing:show():focus()
      return
    end
    existing:close()
  end
  Snacks.terminal.open(cmd, { cwd = root, win = { position = "bottom", height = 15 } }):focus()
end

local function kill_build()
  local cmd, root = build_cmd()
  local term = Snacks.terminal.get(cmd, { cwd = root, create = false })
  if not term then
    vim.notify("No build running", vim.log.levels.INFO)
    return
  end
  local job = vim.b[term.buf].terminal_job_id
  if not job then
    vim.notify("No build running", vim.log.levels.INFO)
    return
  end
  local pid = vim.api.nvim_get_chan_info(job).pid
  if pid then
    vim.uv.kill(-pid, "sigkill")
  else
    vim.fn.jobstop(job)
  end
end

vim.keymap.set({ "n", "t" }, "<F5>", run_build, { desc = "Run build.sh" })
vim.keymap.set({ "n", "t" }, "<S-F5>", kill_build, { desc = "Kill build.sh" })

local function diagnostic_goto(next, severity)
  return function()
    vim.diagnostic.jump({
      count = next and 1 or -1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
    })
  end
end

vim.keymap.set("n", "<F8>", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "<S-F8>", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })

vim.keymap.set("n", "<leader>rr", function()
  dofile(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua")
  vim.notify("Reloaded keymaps.lua")
end, { desc = "Reload Keymaps" })
