return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(ev)
          vim.b[ev.buf].autoformat = false
        end,
      })
    end,
  },
}
