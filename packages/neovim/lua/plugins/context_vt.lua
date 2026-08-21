return {
	{
		"nvim_context_vt",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(_)
			local context_vt = require("nvim_context_vt")
			local enabled = true

			context_vt.setup({
				enabled = enabled,
				prefix = "",
			})

			Snacks.toggle
				.new({
					name = "Context virtual text",
					get = function()
						return enabled
					end,
					set = function(state)
						if state ~= enabled then
							context_vt.toggle_context()
							enabled = state
						end
					end,
				})
				:map("<leader>u;")
		end,
	},
}
