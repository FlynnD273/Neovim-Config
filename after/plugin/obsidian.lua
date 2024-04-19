require("obsidian").setup({
	dir = "~\\Documents\\Notes",

	prepend_note_id = false,

	-- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = false,  -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "🞎", hl_group = "ObsidianTodo" },
      ["x"] = { char = "🗹", hl_group = "ObsidianDone" },
      [">"] = { char = "🞖", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "🞔", hl_group = "ObsidianTilde" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },

	-- Optional, set the log level for Obsidian. This is an integer corresponding to one of the log
	-- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
	-- log_level = vim.log.levels.DEBUG,

	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "Journal",
		-- Optional, if you want to change the date format for daily notes.
		-- 2023/07-July/2023-07-09 Sun
		date_format = "%Y/%m-%B/%Y-%m-%d %a"
	},

	new_notes_location = "current_dir",
	-- Optional, completion.
	completion = {
		-- If using nvim-cmp, otherwise set to false
		nvim_cmp = true,
		-- Trigger completion at 2 chars
		min_chars = 2,
		-- Where to put new notes created from completion. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
	},

	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		local newtitle = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			newtitle = title:gsub("[^0-9a-zA-Z_-. ]", "")
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				newtitle = newtitle .. string.char(math.random(65, 90))
			end
		end
		return newtitle
	end,

	-- Optional, set to true if you don't want Obsidian to manage frontmatter.
	disable_frontmatter = true,

	-- Optional, alternatively you can customize the frontmatter data.
	-- note_frontmatter_func = function(note)
	-- 	-- This is equivalent to the default frontmatter function.
	-- 	local out = { id = note.id, aliases = note.aliases, tags = note.tags }
	-- 	-- `note.metadata` contains any manually added fields in the frontmatter.
	-- 	-- So here we just make sure those fields are kept in the frontmatter.
	-- 	if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
	-- 		for k, v in pairs(note.metadata) do
	-- 			out[k] = v
	-- 		end
	-- 	end
	-- 	return out
	-- end,

	-- Optional, for templates (see below).
	-- templates = {
	-- 	subdir = "Templates",
	-- 	date_format = "%Y-%m-%d-%a",
	-- 	time_format = "%H:%M",
	-- },

	-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
	-- URL it will be ignored but you can customize this behavior here.
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		-- vim.fn.jobstart({ "open", url }) -- Mac OS
		vim.fn.jobstart({"xdg-open", url})  -- linux
	end,

	-- Optional, set to true if you use the Obsidian Advanced URI plugin.
	-- https://github.com/Vinzent03/obsidian-advanced-uri
	use_advanced_uri = true,

	-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
	open_app_foreground = true,

	-- Optional, by default commands like `:ObsidianSearch` will attempt to use
	-- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
	-- first one they find. By setting this option to your preferred
	-- finder you can attempt it first. Note that if the specified finder
	-- is not installed, or if it the command does not support it, the
	-- remaining finders will be attempted in the original order.
	finder = "telescope.nvim",
})

vim.keymap.set("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })

vim.keymap.set("n", "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianToday<CR>")
