local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
--
-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
--
-- if not configs.odoo_lsp then
-- 	configs.odoo_lsp = {
-- 		default_config = {
-- 			name = "odoo-lsp",
-- 			cmd = { "odoo-lsp" },
-- 			filetypes = { "javascript", "xml", "python" },
-- 			root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
-- 		},
-- 	}
-- end
--
--
-- -- if you just want default config for the servers then put them in a table
-- local servers = { "html", "cssls", "tsserver", "clangd", "pyright" }
--
-- for _, lsp in ipairs(servers) do
-- 	lspconfig[lsp].setup({
-- 		on_attach = on_attach,
-- 		on_init = on_init,
-- 		capabilities = capabilities,
-- 	})
-- end
--
-- lspconfig.odoo_lsp.setup{}

--
-- lspconfig.pyright.setup { blabla}
