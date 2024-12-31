return {
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 0
      vim.g.gruvbox_material_foreground = "original" -- mix, material, original
      vim.g.gruvbox_material_background = "hard"     -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = "high"   -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim"  -- Background of floating windows (dim, bright)
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
      -- vim.g.gruvbox_material_dim_inactive_windows = 1

      vim.g.gruvbox_material_better_performance = 0

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    {
      "the-argus/banner.nvim",
      config = function()
        -- vim.cmd('colorscheme base16-gruvbox-dark-hard')
      end,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    opts = {
      alpha = true,
    },
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
      })
      -- vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "ajmwagar/vim-deus",
    priority = 1000,
    config = function()
      -- vim.cmd("colorscheme deus")
    end,
  }

}
