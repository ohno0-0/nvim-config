return {
  -- 模糊查找 (替代 CtrlP)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "全局搜索" })
    end,
  },

}
