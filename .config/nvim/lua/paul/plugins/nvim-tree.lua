return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>e", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
    { "<leader><tab>", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "single",
      enable_git_status = true,
      enable_modified_markers = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
        },
        modified = {
          symbol = " ",
          highlight = "NeoTreeModified",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "",
            deleted = "",
            modified = "",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "float",
        width = 35,
      },
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          -- hide_by_name = {
          --   "node_modules",
          -- },
          -- never_show = {
          --   ".DS_Store",
          --   "thumbs.db",
          -- },
        },
      },
--       git = {
--         ignore = false,
--       },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd =")
            end
          end,
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd =")
            end
          end,
        },
      },
    })
  end,
}
-- return{
--   "nvim-tree/nvim-tree.lua",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     local nvimtree = require("nvim-tree")
--
--     -- recommended settings from nvim-tree documentation
--     vim.g.loaded_netrw = 1
--     vim.g.loaded_netrwPlugin = 1
--
--     -- change color for arrows in tree to light blue
--     vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#458588 ]])
--     vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#458588 ]])
-- -- configure nvim-tree
--     nvimtree.setup({
--       view = {
--         width = 35,
--         relativenumber = true,
--       },
--       -- change folder arrow icons
--       renderer = {
--         indent_markers = {
--           enable = true,
--         },
--         icons = {
--           glyphs = {
--             folder = {
--               arrow_closed = "", -- arrow when folder is closed
--               arrow_open = "", -- arrow when folder is open
--             },
--           },
--         },
--       },
--       -- disable window_picker for
--       -- explorer to work well with
--       -- window splits
--       actions = {
--         open_file = {
--           window_picker = {
--             enable = false,
--           },
--         },
--       },
--       filters = {
--         custom = { ".DS_Store" },
--       },
--       git = {
--         ignore = false,
--       },
--     })
--
--     -- set keymaps
--     local keymap = vim.keymap -- for conciseness
--
--     keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Set Focus on file tree"})
--     keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
--     keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
--     keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
--     keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
--   end,
-- }
