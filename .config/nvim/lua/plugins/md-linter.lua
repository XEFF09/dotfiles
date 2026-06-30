return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/md-linter",
    name = "md-linter",
    ft = "markdown",
    config = function()
      require("md-linter").setup()
    end,
  },
}
