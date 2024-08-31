return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      show_help = false,
    window = {
      layout = 'float',
      title = 'Chat Bre',
      border = 'rounded',
    }
    },

  },
}
