return {
	{
		"venv-selector.nvim",
		auto_enable = true,
		ft = { "python" },
		keys = {
			{
				"<leader>cv",
				"<cmd>VenvSelect<cr>",
				ft = "python",
				desc = "Select venv",
			},
		},
		after = function(_)
			require("venv-selector").setup({
				options = {
					override_notify = false,
				},
			})
		end,
	},
}
