-- Hide the "Neo-tree" label shown above the file explorer
return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    for _, offset in ipairs(opts.options.offsets or {}) do
      if offset.filetype == "neo-tree" then
        offset.text = ""
      end
    end
  end,
}
