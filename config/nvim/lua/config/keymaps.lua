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
