return {
	"ojroques/nvim-osc52",
	config = function()
		require("osc52").setup({
			max_length = 10000,
			trim = false,
			silent = false,
		})

		local function copy()
			-- Only run on yank operator
			if vim.v.event.operator == "y" then
				local regname = vim.v.event.regname
				-- Default to unnamed register if none specified
				regname = regname == "" and '"' or regname
				-- Get yanked text from the register contents in the event
				local yanked_text = table.concat(vim.v.event.regcontents, "\n")
				-- Only copy if yanked text exists
				if yanked_text ~= "" then
					-- Use osc52's copy function to copy this text
					require("osc52").copy(yanked_text)
					if not vim.g.osc52_silent then
						vim.notify(string.format("Copied %d characters to clipboard", #yanked_text))
					end
				end
			end
		end

		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = copy,
		})
	end,
}
