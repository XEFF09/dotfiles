local function fix_transparency()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "EndOfBuffer",
  }

  for _, g in ipairs(groups) do
    vim.cmd("highlight " .. g .. " guibg=NONE ctermbg=NONE")
  end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "WinEnter" }, {
  callback = fix_transparency,
})

vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.api.nvim_set_option_value("winhighlight", "Normal:Normal,NormalFloat:NormalFloat", { scope = "local" })
    end
  end,
})
