return {

	-- highlight moves for f t F T
	{ "unblevable/quick-scope", event = "VeryLazy" },

	{
		"phaazon/hop.nvim",
		event = "BufRead",
		keys = {
			{ "s", "<cmd>:HopChar2<CR>", desc = "Hop 2 chars" },
			{ "S", "<cmd>:HopPattern<CR>", desc = "Hop pattern" },
		},
		config = function()
			require("hop").setup()
		end,
	},
	-- highlight same word as the one under cursor
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = {
			delay = 200,
			filetypes_denylist = {
				"neo-tree",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
					pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
				end,
			})
		end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
	},
}
