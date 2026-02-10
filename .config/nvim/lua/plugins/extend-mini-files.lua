return {
  "nvim-mini/mini.files",
  -- 配置 options
  opts = {
    windows = {
      preview = true, -- 开启预览窗口（右侧第三栏）
      width_focus = 30, -- 中间（当前目录）宽度
      width_preview = 60, -- 预览窗口宽度
      width_nofocus = 30, -- 左侧（父目录）宽度
      max_number = 3, -- 限制最多显示3列 (Parent, Current, Preview)
    },
    -- 这里配置的是全局映射，主要是导航类
    mappings = {
      synchronize = "=", -- 确认修改（类似 Yazi 的提交，虽然 Yazi 是即时的）
    },
  },

  -- 配置 config 函数来处理更复杂的按键绑定
  config = function(_, opts)
    require("mini.files").setup(opts)

    -- 定义一个自动命令，当 mini.files 打开窗口创建 buffer 时触发
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        -- 辅助函数：简化按键映射代码
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc, noremap = true, nowait = true })
        end

        -- 复刻 Yazi 按键逻辑
        map("a", "o", "Create file/dir (Yazi style)")
        map("r", "i", "Rename/Edit (Yazi style)")
        map("o", "<CR>", "Open file/dir (Yazi style)")
        map("i", "<Nop>", "Disable insert")
        map("I", "<Nop>", "Disable Insert at start")
        map("A", "<Nop>", "Disable Append")
        map("<Esc>", require("mini.files").close, "Close")
      end,
    })
  end,

  keys = {
    {
      -- 打开当前文件所在目录
      "<leader>e",
      function()
        -- 检查：如果当前已经是 mini.files 窗口，则关闭它 (Toggle 效果)
        if vim.bo.filetype == "minifiles" then
          require("mini.files").close()
          return
        end
        -- 获取当前 buffer 路径
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = nil
        -- 检查路径是否真实存在且是有效文件
        -- vim.uv.fs_stat 既能判断文件也能判断目录
        if buf_name ~= "" and vim.uv.fs_stat(buf_name) then
          path = buf_name
        else
          -- 如果是空 buffer (No Name) 或无效路径，则打开 CWD
          path = vim.uv.cwd()
        end
        require("mini.files").open(path, true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      -- 打开当前工作目录
      "<leader>E",
      function()
        -- 同样的逻辑：如果在 mini.files 里，先关闭
        if vim.bo.filetype == "minifiles" then
          require("mini.files").close()
          return
        end
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>fm",
      function()
        if vim.bo.filetype == "minifiles" then
          require("mini.files").close()
          return
        end
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      -- 打开根目录
      "<leader>fm",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (Root Dir)",
    },
  },
}
