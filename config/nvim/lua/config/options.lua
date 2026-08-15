-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.opt.relativenumber = false
vim.g.autoformat = false

-- Neovide has no scale/DPI flag of its own; sizing comes entirely from
-- guifont. Unset, it falls back to a large default font, which looks
-- oversized on this HiDPI screen. Match Ghostty's font (font-size = 9 in
-- config/ghostty/config).
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h9"
end
