vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.g.loaded_matchparen = 1
vim.g.OmniSharp_server_use_net6 = 1
vim.g.OmniSharp_highlighting = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.bo.softtabstop = 2
vim.opt.smartindent = false

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- CTRL + Backspace/Delete for deleting whole words
vim.keymap.set("i", "<C-BS>", "<C-W>", { silent = true, noremap = true })
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { silent = true, noremap = true })

vim.keymap.set("n", "<F1>", "<Esc><Esc>:FloatermToggle primary<CR>")
vim.keymap.set("t", "<F1>", "<C-\\><C-n>:FloatermToggle primary<CR>")
vim.keymap.set("i", "<F1>", "<C-\\><C-n>:FloatermToggle primary<CR>")
vim.keymap.set("n", "<F2>", "<Esc><Esc>:FloatermToggle git<CR>")
vim.keymap.set("t", "<F2>", "<C-\\><C-n>:FloatermToggle git<CR>", { desc = "Exit terminal mode" })
vim.keymap.set("i", "<F2>", "<C-\\><C-n>:FloatermToggle git<CR>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "o", "ox<BS>", { silent = true, noremap = true })
vim.keymap.set("n", "O", "Ox<BS>", { silent = true, noremap = true })
vim.keymap.set("i", "<CR>", "<CR>x")

vim.keymap.set("n", "<leader>g", "<Esc><Esc>:FloatermToggle git<CR>", { desc = "Toggle lazygit terminal" })
vim.keymap.set("n", "<leader>v", "<Esc><Esc>:FloatermToggle term<CR>", { desc = "Toggle general terminal" })

vim.keymap.set("n", "<leader>left", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>right", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>down", "<C-w><C-j>", { desc = "Move focus to the bottom window" })
vim.keymap.set("n", "<leader>up", "<C-w><C-k>", { desc = "Move focus to the top window" })

vim.keymap.set("n", "<C-Up>", "<C-u>zz", {})
vim.keymap.set("n", "<C-Down>", "<C-d>zz", {})
vim.keymap.set("n", "n", "nzzzv", {})
vim.keymap.set("n", "N", "Nzzzv", {})

vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("i", "<S-Left>", "<C-o>ge<Esc>li")

vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "d", "\"_d")
vim.keymap.set("v", "d", "\"_d")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("v", "y", "ygv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Copy text highlighting
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "//lazy//lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

plugins = {

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				build = "make",

				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {

					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--auto-hybrid-regex"
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--no-ignore-vcs",
							"--hidden",
							"--follow"
						}
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[F]ind [/] in Open Files" })
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[F]ind [N]eovim files" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					map("K", vim.lsp.buf.hover, "Hover Documentation")

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				gopls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				tsserver = {},
				eslint = {},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			require("catppuccin").setup({
				flavour = "frappe",
			})
			vim.cmd.colorscheme("catppuccin")
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{
		"ggandor/leap.nvim",
		name = "leap",
		config = function()
			local leap = require("leap")
			leap.setup({})
			leap.create_default_mappings()
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"odin",
				"go",
				"zig",
				"cpp",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			refactor = {
				highlight_definitions = false,
				highlight_current_scope = false,
				smart_rename = false,
			},
			indent = { enable = true, disable = { "ruby" } },
			matchup = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify",
		opts = {},
	},

	{
		"voldikss/vim-floaterm",
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"mbbill/undotree"
	},

	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_default_mappings = 0
			vim.g.VM_maps = {
				["Add Cursor Up"] = "<C-S-Up>",
				["Add Cursor Down"] = "<C-S-Down>"
			}
		end,
	}
}

if vim.fn.has('macunix') == 1 then
	table.insert(plugins, {
		"williamboman/mason.nvim",
		opts = {}
	})
end

require("lazy").setup(plugins)

vim.o.mousemoveevent = true

vim.cmd(":FloatermNew --name=git lazygit")
vim.cmd(":FloatermToggle git")
vim.api.nvim_input("<Esc>")
vim.api.nvim_input("<Esc>")

vim.cmd(":FloatermNew --name=term --cwd=<buffer-root>")
vim.cmd(":FloatermToggle term")
vim.api.nvim_input("<Esc>")
vim.api.nvim_input("<Esc>")

-- LSPs
require 'lspconfig'.zls.setup {}
require 'lspconfig'.gopls.setup {}
require 'lspconfig'.lua_ls.setup {
	settings = {
		lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	}
}
require 'lspconfig'.tsserver.setup {}
require 'lspconfig'.eslint.setup {}
require 'lspconfig'.html.setup {}
require 'lspconfig'.htmx.setup {}
require 'lspconfig'.glslls.setup {
	cmd = { "glslls", "--stdin", "--target-env=opengl4.5" }
}
require 'lspconfig'.omnisharp.setup {
	cmd = { "omnisharp" },
}
require 'lspconfig'.ols.setup {
	cmd = { "ols", "-enable_format", false },
	filetypes = { "odin" },
}

-- Enable/Disable LSP
vim.diagnostic.enable(false, nil)

vim.treesitter.language.register("glsl", "vert")
vim.treesitter.language.register("glsl", "tesc")
vim.treesitter.language.register("glsl", "tese")
vim.treesitter.language.register("glsl", "frag")
vim.treesitter.language.register("glsl", "geom")
vim.treesitter.language.register("glsl", "comp")

vim.g.vimspector_enable_mappings = 'HUMAN'
vim.keymap.set("n", "<leader>di", "<Plug>VimspectorBalloonEval", { desc = "Inspect in debug mode." })
vim.keymap.set("x", "<leader>di", "<Plug>VimspectorBalloonEval", { desc = "Inspect in debug mode." })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal indentkeys-=:"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal indentkeys-=<:>"
})

vim.filetype.add({ extension = { templ = "templ" } })

if vim.fn.has('macunix') == 1 then
	require 'lspconfig'.phpactor.setup {}
	require 'lspconfig'.ts_ls.setup {} -- npm install -g typescript typescript-language-server
end

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "*" },
	callback = function()
		vim.opt_local.formatoptions:remove("r")
		vim.opt.formatoptions = vim.opt.formatoptions + {
			o = false,
		}
	end
})
