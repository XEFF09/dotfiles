-- custom theme
return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        color_overrides = {
          mocha = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}

-- vim dark hard
-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     config = function()
--       require("gruvbox").setup({
--         contrast = "hard", -- "hard", "soft" or ""
--       })
--       vim.cmd.colorscheme("gruvbox")
--     end,
--   },
-- }
