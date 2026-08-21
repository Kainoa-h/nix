return {
  {
    "nui.nvim",
    dep_of = { "noice.nvim" },
  },
  {
    "nvim-notify",
    dep_of = { "noice.nvim" },
    after = function(_)
      require("notify").setup({ stages = "fade", timeout = 2000 })

      vim.keymap.set("n", "<leader>snl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
      vim.keymap.set("n", "<leader>snh", function() require("noice").cmd("history") end, { desc = "Noice History" })
      vim.keymap.set("n", "<leader>sna", function() require("noice").cmd("all") end, { desc = "Noice All" })
      vim.keymap.set("n", "<leader>snd", function() require("noice").cmd("dismiss") end, { desc = "Dismiss All" })
    end,
  },
  {
    "noice.nvim",
    event = "DeferredUIEnter",
    after = function(_)
      require("noice").setup({
	lsp = {
	  override = {
	    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	    ["vim.lsp.util.stylize_markdown"] = true,
	  },
	},
	routes = {
	  {
	    filter = { event = "msg_show", any = { { find = "written" }, { find = "bytes" } } },
	    view = "mini",
	  },
	},
	presets = { bottom_search = true, command_palette = true },
      })
    end,
  },
}
