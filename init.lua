-- 屏蔽 nvim-lspconfig 的弃用警告
vim.deprecate = function() end

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  --基础配置
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },

  -- 主题
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- ai给的设置
-- 开启相对行号,不好用,置为false
vim.opt.relativenumber = false
-- 设置 Tab 为 4 个空格
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- 开启真彩色支持
vim.opt.termguicolors = true

-- 普通模式映射
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "保存文件" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "退出" })

-- 窗口导航
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "移到左边窗口" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "移到右边窗口" })

-- 将选中的代码在终端中执行 (利用 0.10.0 新特性)
vim.keymap.set('v', '<leader>x', function()
    -- 获取选中的文本
    local selected_text = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'))
    -- 使用 0.10.0 新增的 vim.system 异步执行
    vim.system({ 'node', '-e', table.concat(selected_text, '\n') }, { text = true }, function(obj)
        print(obj.stdout)
    end)
end, { desc = "执行选中的 JS 代码" })

-- 异步执行 ls 命令
vim.system({ "ls", "-la" }, { text = true }, function(result)
    if result.code == 0 then
        print(result.stdout)
    else
        print("Error: " .. result.stderr)
    end
end)

