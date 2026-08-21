return {
	{
		"nvim-web-devicons",
		dep_of = { "lualine.nvim" },
	},
	{
		"lualine.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		before = function(_)
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,
		after = function(_)
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = {
				diagnostics = {
					Error = " ",
					Warn = " ",
					Info = " ",
					Hint = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			}

			vim.o.laststatus = vim.g.lualine_laststatus

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					component_separators = { left = " ", right = " " },
					section_separators = { left = " ", right = " " },
					disabled_filetypes = {
						statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, status = true },
					},
					lualine_x = {
						{
							function()
								return require("noice").api.status.command.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
							color = function()
								local hl = vim.api.nvim_get_hl(0, { name = "Statement" })
								return { fg = hl.fg and string.format("#%06x", hl.fg) or nil }
							end,
						},
						{
							function()
								return require("noice").api.status.mode.get()
							end,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.mode.has()
							end,
							color = function()
								local hl = vim.api.nvim_get_hl(0, { name = "Constant" })
								return { fg = hl.fg and string.format("#%06x", hl.fg) or nil }
							end,
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
				lualine_z = {
					function()
						local wc = vim.fn.wordcount()
						if wc.visual_words then
							return tostring(wc.visual_words) .. " words"
						else
							return tostring(wc.words) .. " words"
						end
					end,
				},
				},
				inactive_sections = {
					lualine_b = {
						{ "filename", path = 3, status = true },
					},
					lualine_x = { "filetype" },
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			})
		end,
	},
}
