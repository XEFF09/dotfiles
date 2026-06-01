return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
            },
          },
        },
      },
    },
  },
}
