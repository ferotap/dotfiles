return {
	"ziontee113/icon-picker.nvim",
	dependencies = {
		"stevearc/dressing.nvim",
	},
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<Leader>ii", "<cmd>IconPickerNormal<cr>", { desc = "[i]cond [i]nsert" })
		map("n", "<Leader>is", "<cmd>IconPickerNormal symbols<cr>", { desc = "[i]cond [i]nsert" })
		map("n", "<Leader>iy", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
		map("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
		require("icon-picker").setup({
			disable_legacy_commands = true,
		})
	end,
}
