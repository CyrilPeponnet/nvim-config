return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					cmd = { "gopls", "--remote=auto" },
					settings = {
						gopls = {
							-- buildFlags = { "-tags=requires_docker" }, -- custom build flags
							gofumpt = false, -- A stricter gofmt but remove blank line after code blocks
							codelenses = {
								gc_details = true, -- Toggle the calculation of gc annotations
								generate = true, -- Runs go generate for a given directory
								regenerate_cgo = true, -- Regenerates cgo definitions
								tidy = true, -- Runs go mod tidy for a module
								upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
								vendor = true, -- Runs go mod vendor for a module
							},
							diagnosticsDelay = "300ms",
							symbolMatcher = "fuzzy",
							completeUnimported = true,
							staticcheck = true,
							matcher = "Fuzzy",
							usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
							analyses = {
								fieldalignment = true, -- find structs that would use less memory if their fields were sorted
								nilness = true, -- check for redundant or impossible nil comparisons
								shadow = false, -- check for possible unintended shadowing of variables
								unusedparams = true, -- check for unused parameters of functions
								unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
							},
						},
					},
				},
			},
		},
	},
	{
		"ray-x/go.nvim",
		ft = { "go", "gomod", "gosum", "gohtmltmp" },
		config = function()
			require("go").setup({ gofmt = "gopls" })
		end,
		dependencies = { "ray-x/guihua.lua" },
	},
	-- plugin for tests
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-neotest/neotest-go",
			},
			{
				"andythigpen/nvim-coverage",
				config = function()
					require("coverage").setup({
						autoreload = true,
						highlights = {
							-- customize highlight groups created by the plugin
							covered = { bg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
							uncovered = { bg = "#F07178" },
						},
						lang = {
							go = {
								coverage_file = "/tmp/nvim-coverage.out",
							},
						},
					})
				end,
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
						args = { "-timeout=120s", "-coverprofile /tmp/nvim-coverage.out" },
					}),
				},
			})
		end,
	},
}
