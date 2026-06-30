local M = {}

local ns = vim.api.nvim_create_namespace("md-linter")
local api_url = "https://es.net/lint"
local enabled = true
local augroup = vim.api.nvim_create_augroup("md-linter", { clear = true })

local severity_map = {
  error = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  info = vim.diagnostic.severity.INFO,
}

local function lint(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not enabled then
    return
  end
  if vim.bo[bufnr].filetype ~= "markdown" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, "\n")

  local tmp = os.tmpname()
  local f = io.open(tmp, "w")
  if not f then
    return
  end
  f:write(content)
  f:close()

  vim.system({
    "curl",
    "-s",
    "-X",
    "POST",
    api_url,
    "--data-binary",
    "@" .. tmp,
  }, { timeout = 10000 }, function(out)
    os.remove(tmp)
    if out.code ~= 0 then
      return
    end

    local ok, data = pcall(vim.json.decode, out.stdout)
    if not ok or not data or not data.issues then
      return
    end

    local diagnostics = {}
    for _, issue in ipairs(data.issues) do
      local ln = issue.lineNumber
      if ln == nil or ln == vim.NIL then
        ln = 1
      end
      table.insert(diagnostics, {
        lnum = ln - 1,
        col = 0,
        end_lnum = ln - 1,
        end_col = 0,
        severity = severity_map[issue.severity] or vim.diagnostic.severity.WARN,
        message = issue.rule .. ": " .. issue.message,
        source = "md-linter",
      })
    end

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.diagnostic.set(ns, bufnr, diagnostics)
      end
    end)
  end)
end

local function clear(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
end

function M.enable()
  enabled = true
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    group = augroup,
    pattern = "*.md",
    callback = function(args)
      lint(args.buf)
    end,
  })
  lint()
  vim.notify("[md-linter] enabled", vim.log.levels.INFO)
end

function M.disable()
  enabled = false
  vim.api.nvim_clear_autocmds({ group = augroup })
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "markdown" then
      clear(buf)
    end
  end
  vim.notify("[md-linter] disabled", vim.log.levels.INFO)
end

function M.toggle()
  if enabled then
    M.disable()
  else
    M.enable()
  end
end

function M.lint()
  lint()
end

function M.setup()
  vim.api.nvim_create_user_command("MdLint", function()
    lint()
  end, { desc = "Run markdown linter on current buffer" })

  vim.api.nvim_create_user_command("MdLintEnable", function()
    M.enable()
  end, { desc = "Enable markdown linter" })

  vim.api.nvim_create_user_command("MdLintDisable", function()
    M.disable()
  end, { desc = "Disable markdown linter" })

  vim.api.nvim_create_user_command("MdLintToggle", function()
    M.toggle()
  end, { desc = "Toggle markdown linter" })

  M.enable()
end

return M
