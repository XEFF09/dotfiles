-- custom theme
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      transparent_background = true,
      integrations = {
        snacks = true,
        lualine = true,
        native_lsp = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
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
