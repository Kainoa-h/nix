return {
	{
		"conform.nvim",
		auto_enable = true,
		-- cmd = { "" },
		-- event = "",
		-- ft = "",
		keys = {
			{ "<leader>cf", desc = "Format File" },
		},
		-- colorscheme = "",
		after = function(plugin)
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
					rust = nixInfo(nil, "settings", "cats", "rust") and { "rustfmt", "taplo" } or nil,
					typescript = nixInfo(nil, "settings", "cats", "typescript") and { "prettierd" } or nil,
					javascript = nixInfo(nil, "settings", "cats", "javascript") and { "prettierd" } or nil,
					typescriptreact = nixInfo(nil, "settings", "cats", "typescript") and { "prettierd" } or nil,
					javascriptreact = nixInfo(nil, "settings", "cats", "javascript") and { "prettierd" } or nil,
					html = nixInfo(nil, "settings", "cats", "html") and { "prettierd" } or nil,
					css = nixInfo(nil, "settings", "cats", "css") and { "prettierd" } or nil,
					scss = nixInfo(nil, "settings", "cats", "css") and { "prettierd" } or nil,
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					python = nixInfo(nil, "settings", "cats", "python") and { "ruff_format" } or nil,
					cs = nixInfo(nil, "settings", "cats", "csharp") and { "csharpier" } or nil,
					java = nixInfo(nil, "settings", "cats", "java") and { "google-java-format" } or nil,
					sql = nixInfo(nil, "settings", "cats", "sql") and { "sql-formatter" } or nil,
					vue = nixInfo(nil, "settings", "cats", "vue") and { "prettierd" } or nil,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format File" })
		end,
	},
}
