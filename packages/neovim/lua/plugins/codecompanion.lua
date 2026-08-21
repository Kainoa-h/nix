return {
	{
		"codecompanion.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		keys = {
			{
				"<C-a>",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "CC Actions",
			},
			{
				"<leader>a",
				function()
					require("codecompanion").toggle({
						window_opts = {
							layout = "float",
							width = "0.9",
							height = "1",
						}
					})
				end,
				mode = { "n", "v" },
				desc = "CC Chat",
			},
			{
				"ga",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				desc = "CC Add",
			},
		},
		after = function(_)
			require("codecompanion").setup({
				interactions = {
					chat = {
						adapter = "opencode",
					},
				},
			})
			vim.cmd([[cab cc CodeCompanion]])
		end,
	},
}
