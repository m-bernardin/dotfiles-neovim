return {
    "nmac427/guess-indent.nvim",
    enabled = true,
    opts = {
    	auto_cmd = true,
	buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
	    "help",
	    "nofile",
	    "terminal",
	    "prompt",
 	},
	auto_cmd = true,
	override_editorconfig = true,
	
    },
}
