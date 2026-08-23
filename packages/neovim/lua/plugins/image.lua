return {
	{
		"image.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("image").setup({
				backend = "kitty",
				processor = "magick_cli",
				integrations = {
					markdown = {
						enabled = true,
					},
					asciidoc = {
						enabled = false,
					},
					neorg = {
						enabled = false,
					},
					rst = {
						enabled = false,
					},
					typst = {
						enabled = false,
					},
					html = {
						enabled = false,
					},
					css = {
						enabled = false,
					},
				},
				scale_factor = 2.0,
				editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
			})
		end,
	},
}
