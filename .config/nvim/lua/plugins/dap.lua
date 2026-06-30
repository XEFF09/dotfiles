return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("config.nvim-dap")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dapui = require("dapui")
      local dap = require("dap")

      -- Setup dapui with only locals/scopes
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 1 },
            },
            size = 40,
            position = "left",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 2 },
        render = {
          max_type_length = nil,
          max_value_length = nil,
        },
      })

      -- Auto open/close dapui with dap session (proper event listeners)
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "ramboe/ramboe-dotnet-utils",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
