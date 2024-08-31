-- set leader key to space
vim.g.mapleader = " "


local keymap = vim.keymap -- for conciseness

local wk = require("paul.plugins.which-key")

---------------------
-- General Keymaps -------------------
keymap.set("i", "<esc>", "<esc>:wa<CR>", { desc = "Save on escape" })
keymap.set("n", "<esc>", ":wa<CR>", { desc = "Save on escape" })

keymap.set("n", "<leader>qa", ":qa<CR>", { desc = "Quit" })
keymap.set("n","<C-s>", ":w<CR>", {desc = "Save File"})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Copy/past to/from system clipboard (with ctrl-c/ctrl-v)
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-v>', '"+p', { noremap = true, silent = true })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Keymaps for tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Window management
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move cursor to window on the left" }) -- Move cursor to window on the left
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move cursor to window below" }) -- Move cursor to window below
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move cursor to window above" }) -- Move cursor to window above
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move cursor to window on the right" }) -- Move cursor to window on the right

-- Buffer management
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" }) -- close buffer
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next buffer" }) -- next buffer
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Previous buffer" }) -- previous buffer
keymap.set("n", "<tab>", "<cmd>bn<CR>", { desc = "Next buffer" }) -- next buffer
keymap.set("n", "<S-tab>", "<cmd>bp<CR>", { desc = "Previous buffer" }) -- previous buffer

-- Telescope
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Terminal
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle terminal" })
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>tk", "<cmd>q<CR>", { desc = "Kill terminal" })
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })

-- Copilot 
keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "CopilotChat" })

-- None-ls
keymap.set("n", "<leader>xf", "<cmd>lua vim.lsp.buf.format() <CR>", { desc = "Format buffer" })
