local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({  
    -- 第一个元素：一个 table，键是 spec
    spec = {
        {import = "plugins"}
    },
    -- 第二个元素：一个匿名的 table
    {
        rocks = {
            enabled = false,
        },
    }
})
