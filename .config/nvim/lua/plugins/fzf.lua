-- function _G.fzf_rg(term, opts)
-- 	opts = opts or ''
-- 	local preview = vim.fn["fzf#vim#with_preview"]({
-- 	    options = '--prompt "Search Files> " --delimiter : --nth 4.. ',
-- 	})
-- 	local rg_cmd = table.concat({
-- 	    'rg --column --line-number --no-heading',
-- 	    '   --smart-case --hidden --ignore',
-- 	    opts,
-- 	    ' -- ',
-- 	    vim.fn.shellescape(term),
-- 	}, " ")
-- 	vim.fn["fzf#vim#grep"](rg_cmd, 1, preview)
-- end


vim.cmd [[ command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --hidden --smart-case --no-heading --color=always -g "!.git" -g "!src/lib/types" ' .shellescape(<q-args>), 1, <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%') : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'), <bang>0) ]]
