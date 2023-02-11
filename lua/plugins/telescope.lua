local Util = require("util")

return {
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},

			{
				"ahmedkhalf/project.nvim",
				keys = {
					{ "<leader>P", "<cmd>Telescope projects<cr>", desc = "Projects" },
				},
				config = function()
					require("project_nvim").setup({
						{
							manual_mode = false,
							detection_methods = { "pattern" },
							patterns = { ".git" },
							ignore_lsp = {},
							exclude_dirs = {},
							show_hidden = true,
							silent_chdir = true,
							scope_chdir = "global",
							datapath = vim.fn.stdpath("data"),
						},
					})
					require("telescope").load_extension("projects")
				end,
			},
		},
		cmd = "Telescope",
		version = false, -- telescope did only one release, so use HEAD for now
		keys = {
			{
				"<leader>k",
				"<cmd>Telescope buffers show_all_buffers=true<cr>",
				desc = "Switch Buffer",
			},
			{ "<leader>/", require("util").telescope("live_grep"), desc = "Live grep" },
			{ "<leader><space>", require("util").telescope("files"), desc = "Find files" },
			-- search
			{ "<leader>sw", require("util").telescope("grep_string"), desc = "Grep word under cursor" },
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>sm", "<cmd>Telescope marks ", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options", desc = "Options" },
		},
		opts = {
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						preview_height = 0.7,
						width = 0.9,
					},
				},
				prompt_prefix = " ",
				selection_caret = " ",
				theme = "dropdown",
				mappings = {
					i = {
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<a-i>"] = function()
							Util.telescope("find_files", { no_ignore = true })()
						end,
						["<a-h>"] = function()
							Util.telescope("find_files", { hidden = true })()
						end,
						["<C-Down>"] = function(...)
							return require("telescope.actions").cycle_history_next(...)
						end,
						["<C-Up>"] = function(...)
							return require("telescope.actions").cycle_history_prev(...)
						end,
					},
				},
			},
		},
	},
}
