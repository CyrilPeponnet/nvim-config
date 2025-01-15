-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "v", "n", "s" }, "<leader>w", "<cmd>w!<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "<leader>o", ":!open <c-r><c-a><cr>", { desc = "Open under cursor with system" })
