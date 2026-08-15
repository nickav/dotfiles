-- Show dotfiles (files/folders starting with ".") but keep respecting
-- .gitignore, and always keep the .git folder itself hidden.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true, ignored = false },
          explorer = { hidden = true, ignored = false },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = { ".git" },
        },
      },
    },
  },
}
