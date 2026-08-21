return {
	{
		"nvim-lspconfig",
		auto_enable = true,
		-- NOTE: define a function for lsp,
		-- and it will run for all specs with type(plugin.lsp) == table
		-- when their filetype trigger loads them
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
		-- set up our on_attach function once before the spec loads
		before = function(_)
			local document_highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					local bufnr = args.buf

					if client:supports_method("textDocument/documentHighlight")
						and not vim.b[bufnr].lsp_document_highlight_enabled
					then
						vim.b[bufnr].lsp_document_highlight_enabled = true

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = document_highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = document_highlight_group,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end
						vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
					end

					nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
					nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					nmap("<leader>cgd", vim.lsp.buf.definition, "Goto Definition")
					nmap("<leader>cd", vim.diagnostic.open_float, "Diagnostic at Cursor")
					nmap("<leader>cgr", function() Snacks.picker.lsp_references() end, "Goto References")
					nmap("<leader>cgI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
					nmap("<leader>cs", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
					nmap("<leader>cw", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")

					-- See `:help K` for why this keymap
					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

					-- Lesser used LSP functionality
					nmap("<leader>cgD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Create a command `:Format` local to the LSP buffer
					vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })

				end,
			})
		end,
	},
	{
		-- lazydev makes your lua lsp load only the relevant definitions for a file.
		-- It also gives us a nice way to correlate globals we create with files.
		"lazydev.nvim",
		auto_enable = true,
		cmd = { "LazyDev" },
		ft = "lua",
		after = function(_)
			require("lazydev").setup({
				library = {
					{ words = { "nixInfo%.lze" }, path = nixInfo("lze", "plugins", "start", "lze") .. "/lua" },
					{
						words = { "nixInfo%.lze" },
						path = nixInfo("lzextras", "plugins", "start", "lzextras") .. "/lua",
					},
				},
			})
		end,
	},
	{
		-- name of the lsp
		"lua_ls",
		for_cat = "lua",
		-- provide a table containing filetypes,
		-- and then whatever your functions defined in the function type specs expect.
		-- in our case, it just expects the normal lspconfig setup options,
		-- but with a default on_attach and capabilities
		lsp = {
			-- if you provide the filetypes it doesn't ask lspconfig for the filetypes
			-- (meaning it doesn't call the callback function we defined in the main init.lua)
			filetypes = { "lua" },
			settings = {
				Lua = {
					signatureHelp = { enabled = true },
					diagnostics = {
						globals = { "nixInfo", "vim" },
						disable = { "missing-fields" },
					},
				},
			},
		},
		-- also these are regular specs and you can use before and after and all the other normal fields
	},
	{
		"nixd",
		enabled = nixInfo.isNix, -- mason doesn't have nixd
		for_cat = "nix",
		lsp = {
			filetypes = { "nix" },
			settings = {
				nixd = {
					nixpkgs = {
						expr = [[import <nixpkgs> {}]],
					},
					options = {},
					formatting = {
						command = { "nixfmt" },
					},
					diagnostic = {
						suppress = {
							"sema-escaping-with",
						},
					},
				},
			},
		},
	},
	{
		"rust_analyzer",
		for_cat = "rust",
		lsp = {
			filetypes = { "rust" },
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	},
	{
		"vtsls",
		for_cat = { "typescript", "javascript" },
		lsp = {
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			settings = {
				vtsls = {
					autoUseWorkspaceTsdk = true,
				},
			},
		},
	},
	{
		"html",
		for_cat = "html",
		lsp = {
			filetypes = { "html" },
		},
	},
	{
		"cssls",
		for_cat = "css",
		lsp = {
			filetypes = { "css", "scss", "less" },
		},
	},
	{
		"roslyn_ls",
		for_cat = "csharp",
		lsp = {
			filetypes = { "cs" },
		},
	},
	{
		"jdtls",
		for_cat = "java",
		lsp = {
			filetypes = { "java" },
		},
	},
	{
		"angularls",
		for_cat = "angular",
		lsp = {
			filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
		},
	},
	{
		"vue_ls",
		for_cat = "vue",
		lsp = {
			filetypes = { "vue" },
		},
	},
	{
		"pyright",
		for_cat = "python",
		lsp = {
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
					},
				},
			},
		},
	},
	{
		"sqls",
		for_cat = "sql",
		lsp = {
			filetypes = { "sql" },
		},
	},
	{
		"marksman",
		for_cat = "markdown",
		lsp = {
			filetypes = { "markdown" },
		},
	},
	{
		"emmet_ls",
		for_cat = { "html", "css", "react" },
		lsp = {
			filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
		},
	},
	{
		"crates.nvim",
		for_cat = "rust",
		ft = "toml",
		after = function(_)
			require("crates").setup()
		end,
	},
}
