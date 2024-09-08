vim.keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>")
vim.keymap.set("n", "gD", "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>")
vim.keymap.set("n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>")
vim.keymap.set("n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>")
