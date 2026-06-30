local dap = require("dap")

-- 🔧 C# adapter (netcoredbg)
-- NOTE: For M3 macOS, netcoredbg binary should be in ~/.local/bin/
dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.exepath("netcoredbg") ~= "" and "netcoredbg" or vim.fn.expand("~/.local/bin/netcoredbg"),
  args = { "--interpreter=vscode" },
}

-- 🎯 C# configuration
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch .NET App",
    request = "launch",

    program = function()
      -- Try to find built DLL automatically, or ask user
      local ok, autopicker = pcall(require, "dap-dll-autopicker")
      if ok then
        return autopicker.build_dll_path()
      else
        -- Fallback: ask user to manually specify path
        return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end
    end,

    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    console = "integratedTerminal",
  },
}

-- Add debug output for when dap starts/stops
local dap_session = require("dap")
dap_session.listeners.before.launch.debug_msg = function()
  print("[DAP] Starting debug session...")
end

dap_session.listeners.before.event_terminated.debug_msg = function()
  print("[DAP] Debug session terminated")
end
