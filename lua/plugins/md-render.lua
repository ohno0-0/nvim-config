return {
  "delphinus/md-render.nvim",
  build = "make", -- 可能需要编译，参考插件文档
  config = function()
    -- 可选：进行一些基本设置
    require("md-render").setup({
      -- 你可以在这里添加配置项
    })
  end,
}
