local M = {}
function M.setup()
	local status_ok, comment = pcall(require, "Comment")
	if not status_ok then
		vim.notify("Comment not found")
		return
	end

	comment.setup {
		pre_hook = function(ctx)
			-- Set ts_context_commentstring will change the lua comment, and can't set to normal
			-- 
			-- local U = require "Comment.utils"
			-- local location = nil
			-- if ctx.ctype == U.ctype.block then
			-- location = require("ts_context_commentstring.utils").get_cursor_location()
			-- elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			-- location = require("ts_context_commentstring.utils").get_visual_start_location()
			-- end
			--
			-- return require("ts_context_commentstring.internal").calculate_commentstring {
			-- key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			-- location = location,
			-- }
		end,
	}

	-- Custom config
	-- local ft = require('Comment.ft')
	-- Set only line comment
	-- .set('yaml', '#%s')
	-- Or set both line and block commentstring
	-- .set('javascript', {'//%s', '/*%s*/'})
	-- ft.set('lua', { '-- %s' })
end

return M
