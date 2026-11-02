return {
	{
		"codecompanion.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		keys = {
			{
				"<leader><C-a>",
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
				adapters = {
					acp = {
						codex = function()
							return require("codecompanion.adapters").extend("codex", {
								defaults = {
									auth_method = "chat-gpt",
								},
							})
						end,
					},
				},
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
