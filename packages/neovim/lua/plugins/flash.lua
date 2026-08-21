return {
	{
		"flash.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(_)
			require("flash").setup({
				modes = {
					char = {
						jump_labels = "asdfghjklqwertyuiopzcvbnm",
					},
				},
			})
		end,
	},
}
