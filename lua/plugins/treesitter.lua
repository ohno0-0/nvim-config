return {
  -- Treesitter (语法高亮与折叠)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup{
            indent = {
                enable = true,  -- 启用缩进模块
                disable = {},   -- 禁用缩进的语言列表（可选）
            }
        }
        treesitter.install { 'c', 'cpp', 'python' }
        
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'c', 'cpp', 'python' },
            callback = function()
                vim.treesitter.start()
            end,
        })             

        --vim.api.nvim_create_autocmd('FileType', {
            --pattern = { 'c', 'cpp', 'python' },
            --callback = function()
                --vim.treesitter.start()
            --end,
        --})
    end
  },

}
