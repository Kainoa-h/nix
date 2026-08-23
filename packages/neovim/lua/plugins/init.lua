vim.g.firenvim_config = {
	localSettings = {
			['.*'] = {
					takeover = "never",
					selector = "",
			}
	}
}

local specs = {
	{ import = "plugins.colorschemes" },
	{ import = "plugins.flash" },
	{ import = "plugins.firenvim" },
	{
		"nvim-surround",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function(plugin)
			require("nvim-surround").setup()
			vim.keymap.set("x", "gsa", "<Plug>(nvim-surround-visual)", { desc = "Add Surround" })
			vim.keymap.set("n", "gsa", "<Plug>(nvim-surround-normal)", { desc = "Add Surround Motion" })
			vim.keymap.set("n", "gsd", "<Plug>(nvim-surround-delete)", { desc = "Delete Surround" })
		end,
	},
}

if not vim.g.started_by_firenvim then
	vim.list_extend(specs, {
		{ import = "plugins.snacks" },
		{ import = "plugins.lsp" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.conform" },
		{ import = "plugins.lint" },
		{ import = "plugins.blink" },
		{ import = "plugins.lualine" },
		{ import = "plugins.noice" },
		{ import = "plugins.gitsigns" },
		{ import = "plugins.bufferline" },
		{ import = "plugins.no-neck-pain" },
		{ import = "plugins.render-markdown" },
		{ import = "plugins.context_vt" },
		{ import = "plugins.venv-selector" },
		{ import = "plugins.codecompanion" },
		{ import = "plugins.image" },
		{
			"yanky.nvim",
			auto_enable = true,
			event = "DeferredUIEnter",
			keys = {
				{
					"<leader>P",
					function()
						Snacks.picker.yanky()
					end,
					mode = { "n", "x" },
					desc = "Yank History"
				},
			},
			after = function(_)
				require("yanky").setup({})
			end,
		},
		{
			"todo-comments.nvim",
			auto_enable = true,
			event = "DeferredUIEnter",
			after = function(_)
				require("todo-comments").setup({})
				vim.keymap.set("n", "<leader>st", function()
					require("snacks").picker.todo_comments()
				end, { desc = "Todo" })
			end,
		},
		{
			"colorful-menu.nvim",
			auto_enable = true,
			on_plugin = { "blink.cmp" },
		},
		{
			"vim-startuptime",
			auto_enable = true,
			cmd = { "StartupTime" },
			before = function(_)
				vim.g.startuptime_event_width = 0
				vim.g.startuptime_tries = 10
				vim.g.startuptime_exe_path = nixInfo(vim.v.progpath, "progpath")
			end,
		},
		{
			"fidget.nvim",
			auto_enable = true,
			event = "DeferredUIEnter",
			after = function(plugin)
				require("fidget").setup({})
			end,
		},
		{
			"mini.files",
			auto_enable = true,
			event = "DeferredUIEnter",
			after = function(plugin)
				require("mini.files").setup({})
				vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open()<CR>", { desc = "Mini Files" })
				vim.keymap.set("n", "<leader>fd", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "Mini Files in dir" })
			end,
		},
		{
			"which-key.nvim",
			auto_enable = true,
			event = "DeferredUIEnter",
			after = function(plugin)
				require("which-key").setup({
					preset = "helix",
				})
				require("which-key").add({
					{ "<leader><leader>", group = "buffer commands" },
					{ "<leader><leader>_", hidden = true },
					{ "<leader>c", group = "[c]ode" },
					{ "<leader>c_", hidden = true },
					{ "<leader>d", group = "[d]ocument" },
					{ "<leader>d_", hidden = true },
					{ "<leader>g", group = "[g]it" },
					{ "<leader>g_", hidden = true },
					{ "<leader>m", group = "[m]arkdown" },
					{ "<leader>m_", hidden = true },
					{ "<leader>r", group = "[r]ename" },
					{ "<leader>r_", hidden = true },
					{ "<leader>s", group = "[s]earch" },
					{ "<leader>sn", group = "noice" },
					{ "<leader>t", group = "[t]oggles" },
					{ "<leader>t_", hidden = true },
				})
			end,
		},
	})
end

return specs
