return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  -- ft = "markdown", -- If you decide to lazy-load anyway

  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    "nvim-treesitter/nvim-treesitter",

    "nvim-tree/nvim-web-devicons"
  },

  preview = {
    icon_provider = "mini",
    enabled = true,
    enable_hybrid_mode = false,
    modes = { "n", "no", "c" },
    hybrid_modes = { "n" },
    linewise_hybrid_mode = true,
    -- callbacks = {
    --   on_enable = function(_, win)
    --     vim.wo[win].conceallevel = 1;
    --     vim.wo[win].concealcursor = "c";
    --   end
    -- }
  },
}
