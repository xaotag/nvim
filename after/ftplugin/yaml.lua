-- 如果路径包含 mihomo，禁用自动格式化
local path = vim.fn.expand("%:p")
if path:match("mihomo") then
	vim.b.autoformat = false
	-- 或者针对 conform.nvim
	vim.g.conform_autoformat = false
end
