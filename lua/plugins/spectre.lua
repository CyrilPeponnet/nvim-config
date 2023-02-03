return {

	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>r", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},
}
