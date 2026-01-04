vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.g.mapleader = " "
vim.o.clipboard = 'unnamedplus'

vim.keymap.set('n', '<leader>w', ":write<CR>")
vim.keymap.set('n', '<leader>q', ":quit<CR>")

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" }
})


require "mini.pairs".setup()
require "mini.files".setup({
	windows = {
		preview = true,
		width_focus = 30,
		width_preview = 30
	},
	options = {
		use_as_default_explorer = true,
	},
	mappings = {
		close = 'q',
		go_in = '<CR>'
	}
})

local minifiles_toggle = function()
    if not MiniFiles.close() then
        MiniFiles.open()
    end
end
vim.keymap.set('n', '<leader>e', minifiles_toggle, { desc = 'Toggle MiniFiles' })


local language_server_list = { "lua_ls", "pyright", "jsonls", "html", "cssls", "yamlls", "dockerls", "terraformls", "sqlls", "clangd", "gopls", "rust_analyzer", "ts_ls" }

require "mason".setup()
require "mason-lspconfig".setup({
	ensure_installed = language_server_list
})
vim.lsp.enable(language_server_list)

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' }) -- 정의로 이동
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' }) -- 구현으로 이동
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })   -- 정보 확인
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { desc = 'Code Action' })     -- 코드 수정 제안

-- 에러/경고 목록 이동
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to Before Error' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to Next Error' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Check Error Details' }) -- 에러 상세 내용 팝업 (커서 아래 에러 확인)

-- 1. 창 이동을 더 직관적으로 (Ctrl + h, j, k, l)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move cursor into left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move cursor into down split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move cursor into up(above) split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move cursor into right split' })

-- 2. 창 크기 조절 (Alt<option> + 화살표)
vim.keymap.set('n', '<leader><Up>', ':resize +2<CR>', { desc = '창 높이 늘리기' })
vim.keymap.set('n', '<leader><Down>', ':resize -2<CR>', { desc = '창 높이 줄이기' })
vim.keymap.set('n', '<leader><Left>', ':vertical resize -2<CR>', { desc = '창 너비 줄이기' })
vim.keymap.set('n', '<leader><Right>', ':vertical resize +2<CR>', { desc = '창 너비 늘리기' })

-- 3. 창 분할 단축키 (Leader 활용)
-- <leader>가 Space라면, Space + v 로 세로 분할을 즉시 실행합니다.
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = '세로로 창 나누기' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = '가로로 창 나누기' })
vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = '현재 창 닫기' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 투명 배경 설정
vim.cmd("colorscheme kanagawa-dragon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
