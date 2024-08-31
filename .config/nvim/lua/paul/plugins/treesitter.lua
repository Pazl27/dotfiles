return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "python",
          "rust",
          "yaml",
          "cmake",
          "cpp",
          "c",
          "java",
          "make",
          "markdown_inline",
          "toml",
        }
      })
    end
  }
}
