return {
	{
		"bufferline.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("bufferline").setup({
				options = {
					mode = "buffers",
					style_preset = require("bufferline").style_preset.default,
					themable = true,
					numbers = "none",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,
					indicator = {
						icon = "▎",
						style = "icon",
					},
					buffer_close_icon = "󰅖",
					modified_icon = "● ",
					close_icon = " ",
					left_trunc_marker = " ",
					right_trunc_marker = " ",
					max_name_length = 18,
					max_prefix_length = 15,
					truncate_names = true,
					tab_size = 18,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_update_on_event = true,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icons = {
							error = "󰅚 ",
							warning = "󰀪 ",
							info = "󰋽 ",
							hint = "󰌶 ",
						}

						if diagnostics_dict.error then
							return icons.error
						elseif diagnostics_dict.warning then
							return icons.warning
						elseif diagnostics_dict.info then
							return icons.info
						elseif diagnostics_dict.hint then
							return icons.hint
						end

						return ""
					end,
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true,
					duplicates_across_groups = true,
					persist_buffer_sort = false,
					move_wraps_at_ends = false,
					separator_style = "slant",
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					auto_toggle_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "insert_at_end",
					pick = {
						alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
					},
				},
			})
			vim.keymap.set('n', '<leader>h', '<Cmd>BufferLinePick<CR>', { desc = "Pick buffer", silent = true })
		end,
	},
}
