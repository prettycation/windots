return {
  {
    "rainzm/flash-zh.nvim",
    dependencies = { "folke/flash.nvim" },
    event = "VeryLazy",
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          local Flash = require("flash")

          -- 定义双字符标签样式
          local function format_two_char(opts)
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end

          require("flash-zh").jump({
            chinese_only = false,

            -- 允许先输入一个字符
            search = {
              -- 允许输入，默认配置
            },

            -- 禁大写
            label = {
              uppercase = false,
              exclude = "",
            },

            labeler = function(matches, state)
              -- 指定 26 个小写标签
              local labels = vim.split("asdfghjklqwertyuiopzxcvbnm", "")

              -- A. 匹配少 -> 单字符
              if #matches <= #labels then
                for m, match in ipairs(matches) do
                  match.label = labels[m]
                end

              -- B. 匹配多 -> 双字符
              else
                for m, match in ipairs(matches) do
                  local idx1 = math.floor((m - 1) / #labels) + 1
                  local idx2 = (m - 1) % #labels + 1
                  if idx1 > #labels then
                    idx1 = #labels
                  end

                  match.label1 = labels[idx1]
                  match.label2 = labels[idx2]

                  -- 初始显示第一位
                  match.label = match.label1
                end

                -- 使用 vim.schedule 修改，避免在渲染循环中直接修改导致的状态竞争
                vim.schedule(function()
                  -- 强制双字样式
                  state.opts.label.format = format_two_char
                  -- 劫持 Action
                  state.opts.action = function(match, inner_state)
                    inner_state:hide()
                    Flash.jump({
                      search = { max_length = 0 },
                      highlight = { matches = false },
                      label = { format = format_two_char, uppercase = false },
                      matcher = function(win)
                        return vim.tbl_filter(function(m)
                          return m.label == match.label and m.win == win
                        end, inner_state.results)
                      end,
                      labeler = function(inner_matches)
                        for _, m in ipairs(inner_matches) do
                          m.label = m.label2
                        end
                      end,
                    })
                  end
                end)
              end
            end,
          })
        end,
        desc = "Flash Smart Jump",
      },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
    },
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      label = { uppercase = false },
      modes = { char = { enabled = false } },
    },
  },
}
