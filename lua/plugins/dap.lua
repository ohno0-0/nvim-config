-- ai给的lua代码
-- 在你的 lua 配置文件中 (如 init.lua 或 plugins/dap.lua)
return {
  -- 1. 核心 DAP 插件
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- 2. UI 插件 (用于显示断点、变量悬浮等)
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      -- 3. 虚拟文本插件 (在代码旁边显示变量值)
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      -- 基础配置
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- 4. 安装适配器 (以 C++ 为例)
      -- 你需要手动在系统里安装 debug adapter (如 cpptools)
      -- 或者使用这个自动安装适配器的插件
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
          "codelldb", -- 推荐用于 C/C++/Rust
          -- "cppdbg" -- 或者使用 Microsoft 的 cpptools
        },
      })

      -- 键位映射 (示例)
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- 打开/关闭调试界面
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F1>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>b", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)

      -- 自动打开/关闭 UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  
  -- Mason 插件 (用于管理 LSP 和 DAP 适配器)
  { "williamboman/mason.nvim" },
  { "jay-babu/mason-nvim-dap" },
}
