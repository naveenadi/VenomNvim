--[===[
    NOTE:
        to know more about filetype_exclude and buftype_exclude
        https://github.com/lukas-reineke/indent-blankline.nvim/issues/284
		:set buftype
--]===]

local indent_blankline_ok, indent = pcall(require, "indent_blankline")
if not indent_blankine_ok then return end

indent.setup {
  show_current_context = true,
	show_current_context_start = true,
  char = '┊',
  show_trailing_blankline_indent = false,
}
