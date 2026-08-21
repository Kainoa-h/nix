return {
	{
		"nvim-lint",
		auto_enable = true,
		-- cmd = { "" },
		event = "FileType",
		-- ft = "",
		-- keys = "",
		-- colorscheme = "",
		after = function(plugin)
			require("lint").linters_by_ft = {
				javascript = nixInfo(nil, "settings", "cats", "javascript") and { "eslint_d" } or nil,
				typescript = nixInfo(nil, "settings", "cats", "typescript") and { "eslint_d" } or nil,
				javascriptreact = nixInfo(nil, "settings", "cats", "javascript") and { "eslint_d" } or nil,
				typescriptreact = nixInfo(nil, "settings", "cats", "typescript") and { "eslint_d" } or nil,
				vue = nixInfo(nil, "settings", "cats", "vue") and { "eslint_d" } or nil,
				python = nixInfo(nil, "settings", "cats", "python") and { "ruff" } or nil,
				css = nixInfo(nil, "settings", "cats", "css") and { "stylelint" } or nil,
				scss = nixInfo(nil, "settings", "cats", "css") and { "stylelint" } or nil,
				html = nixInfo(nil, "settings", "cats", "html") and { "html-tidy" } or nil,
				sql = nixInfo(nil, "settings", "cats", "sql") and { "sqlfluff" } or nil,
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
