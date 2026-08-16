-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.opt.relativenumber = true
vim.g.autoformat = false

-- Neovide has no scale/DPI flag of its own; sizing comes entirely from
-- guifont. Unset, it falls back to a large default font, which looks
-- oversized on this HiDPI screen. Bumped slightly above Ghostty's terminal
-- font size, since Neovide's own text otherwise reads a bit small in the GUI.
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h11"

  -- Speed up animations (defaults feel sluggish, especially Ctrl+D/U scrolling).
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0.05
end
