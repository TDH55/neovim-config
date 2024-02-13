vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- copy and paste to/from system clipboard wihtout having to specify the register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>pp", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format)
