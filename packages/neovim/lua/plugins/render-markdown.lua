return {
	{
		"mini.icons",
		dep_of = { "render-markdown.nvim" },
	},
	{
		"render-markdown.nvim",
		auto_enable = true,
		ft = { "markdown", "codecompanion" },
		keys = {
			{
				"<leader>up",
				function()
					require("render-markdown").preview()
				end,
				ft = "markdown",
				desc = "Preview Markdown",
			},
			{
				"<leader>um",
				function()
					require("render-markdown").toggle()
				end,
				ft = { "markdown", "codecompanion" },
				desc = "Toggle Markdown",
			}
		},
		after = function(plugin)
			require("render-markdown").setup({
				file_types = { "markdown", "codecompanion" },
			})
		end,
	},
}
