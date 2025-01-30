return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      debug = true, -- Enable debugging
      show_help = false,
      window = {
        layout = 'float',
        title = 'Chat Bre',
        border = 'rounded',
      }
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
