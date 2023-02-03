---@type Config
local M = {}

---@class Config
local defaults = {
	colorscheme = "onedarker",
	-- cmp source name pretty
	cmp_source_names = {
		nvim_lsp = "[LSP]",
		path = "[Path]",
		vsnip = "[Snippet]",
		luasnip = "[Snippet]",
		buffer = "[Buffer]",
		treesitter = "[TreeSitter]",
	},
	-- icons used by other plugins
	icons = {
		diagnostics = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
		git = {
			added = " ",
			modified = " ",
			removed = " ",
		},
		kinds = {
			Array = " ",
			Boolean = " ",
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Namespace = " ",
			Null = "ﳠ ",
			Number = " ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		},
	},
}

---@type Config
local options

---@param opts? Config
function M.setup(opts)
	options = vim.tbl_deep_extend("force", defaults, opts or {})

	-- load them now so they affect the opened buffers
	require("config.autocmds")
	require("config.keymaps")

	vim.cmd.colorscheme(M.colorscheme)
end

M.did_init = false
function M.init()
	if not M.did_init then
		M.did_init = true
		-- delay notifications till vim.notify was replaced or after 500ms
		require("util").lazy_notify()
	end
end

setmetatable(M, {
	__index = function(_, key)
		if options == nil then
			return vim.deepcopy(defaults)[key]
		end
		---@cast options Config
		return options[key]
	end,
})

return M
