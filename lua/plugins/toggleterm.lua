return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup{
      -- 方向设置为底部水平分屏
      direction = "horizontal",
      -- 终端高度占屏幕的比例
      size = 20,
      -- 打开终端时自动进入插入模式
      start_in_insert = true,
    }

    -- 设置快捷键：<leader>t 切换底部终端
    vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
    
    -- 在终端模式下的快捷键
    vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })

    -- 退出终端模式
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

    -- F4: 底部终端,固定高度 10 行(独立于 <leader>t 的 size=20)
    local Terminal = require("toggleterm.terminal").Terminal
    local bottom_term = Terminal:new({
      direction = "horizontal",
      size = 10,
      start_in_insert = true,
      hidden = true,
    })
    vim.keymap.set({ "n", "t" }, "<F4>", function()
      bottom_term:toggle()
    end, { desc = "terminal toggle bottom (height 10)", noremap = true, silent = true })
  end
}
