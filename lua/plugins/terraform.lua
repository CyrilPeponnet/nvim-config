return {
	{ "hashivim/vim-terraform" },
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				terraformls = {},
				tflint = {},
			},
		},
	},
}
