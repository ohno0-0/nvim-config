return {
    -- LSP 配置
    { 
      "williamboman/mason.nvim", 
      version = "v1.10.0",
      config = true 
    },

    { 
      "williamboman/mason-lspconfig.nvim", 
      version = "v1.10.0", 
      dependencies = { "williamboman/mason.nvim" } 
    },

    {
      "neovim/nvim-lspconfig", 
      dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
      config = function()
        -- 1. 设置 Mason
        require("mason").setup()
    
        -- 2. 配置 mason-lspconfig
        require("mason-lspconfig").setup({
          ensure_installed = { "clangd", "pyright" },
          automatic_installation = true,
        })

        -- 添加 nvim-cmp 的 LSP 能力支持，否则补全和跳转可能异常
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- 4. LSP 快捷键绑定 (LspAttach 是 Neovim 0.10+ 推荐的做法，你写的是对的)
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end,
        })

        -- 5. 启动 LSP 服务器 (传入 capabilities)
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup {
          capabilities = capabilities,
          -- background-index: 让 clangd 预建全工程符号索引,跨文件跳转(如 page_alloc.c -> vmscan.c)才可靠
          cmd = { "clangd", "--background-index", "--pch-storage=memory", "--limit-results=0" },
        }
        lspconfig.pyright.setup { capabilities = capabilities }
      end,
    },

}
