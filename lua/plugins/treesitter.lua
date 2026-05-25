return {
  -- Treesitter (语法高亮与折叠)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()
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
