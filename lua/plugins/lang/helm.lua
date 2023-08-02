-- detach lsp for helm files
local function detach_yamlls()
	local clients = vim.lsp.get_active_clients()
	for client_id, client in pairs(clients) do
		if client.name == "yamlls" or client.name == "docker_compose_language_service" then
			vim.lsp.buf_detach_client(0, client_id)
		end
	end
end

local gotmpl_group = vim.api.nvim_create_augroup("_gotmpl", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = gotmpl_group,
	pattern = "yaml",
	callback = function()
		vim.schedule(function()
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			for _, line in ipairs(lines) do
				if string.match(line, "{{.+}}") then
					vim.defer_fn(detach_yamlls, 500)
					return
				end
			end
		end)
	end,
})

-- filter the diagnostic we dont want
local function filter_diagnostics(diagnostic)
	-- if we deal with a helm file we filter out the yamlls and docker_compose_language_service
	if vim.bo.filetype == "helm" then
		-- somehow the source is nil for some so we filter out all
		if diagnostic.source == nil or diagnostic.source == "YAML" then
			return false
		end
	end
	return true
end

-- override the default diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(function(_, result, ctx, config)
	result.diagnostics = vim.tbl_filter(filter_diagnostics, result.diagnostics)
	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end, {})

return {

	{
		"towolf/vim-helm",
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				helm_ls = {},
			},
		},
	},
}
