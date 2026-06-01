return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = require("catppuccin.utils.lualine")("mocha"),
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)

    vim.schedule(function()
      local modes = { "normal", "insert", "visual", "replace", "command", "terminal" }
      local sections = { "c", "x", "y", "z" }

      for _, mode in ipairs(modes) do
        for _, section in ipairs(sections) do
          local hl_group = "lualine_" .. section .. "_" .. mode
          vim.api.nvim_set_hl(0, hl_group, { bg = "NONE" })
        end
      end
    end)
  end,
}
