local Util = require("util")
return {
	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>r", function() require("spectre").open({cwd = Util.get_root() }) end, desc = "Replace in files (Spectre)" },
    },
	},
}
