return {
  -- Lua 开发环境
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- 加载 luvit 类型
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        
        -- 预加载核心框架和常用插件
        "LazyVim",
        { path = "nvim-lspconfig", words = { "lspconfig" } },
        { path = "nvim-cmp", words = { "cmp" } },
        { path = "blink.cmp", words = { "blink" } },
      },
      -- 显式启用集成
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    },
  },

  -- Lua 语言服务器的具体设置
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false, -- 推荐关闭
                -- 必须清空 ignoreDir，否则插件内的 /lua 目录会被跳过
                ignoreDir = {},
                -- 允许更深入的库搜索
                pathStrict = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              -- 诊断设置
              diagnostics = {
                -- globals = { "vim" },
                -- 忽略一些在模板文件中常见的、由于跨插件引用导致的注解警告
                disable = { "undefined-doc-name", "undefined-field" },
              },
            },
          },
        },
      },
    },
  },
}
