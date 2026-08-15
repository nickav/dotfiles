-- Remove the clock from the statusline (lualine_z)
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections.lualine_z = {}
  end,
}
