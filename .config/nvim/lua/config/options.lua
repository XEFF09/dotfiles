-- Performance settings for large files
vim.opt.redrawtime = 10000 -- Increase redraw timeout (default is 2000ms)
vim.opt.synmaxcol = 500 -- Only highlight first 500 columns (prevents lag on long lines)

-- Vue file specific performance
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vue",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(buf)
    
    -- For very large Vue files (>2000 lines), increase timeouts
    if line_count > 2000 then
      vim.bo.syntax = "on"
      vim.opt_local.redrawtime = 20000
      vim.opt_local.synmaxcol = 300
    end
  end,
})
