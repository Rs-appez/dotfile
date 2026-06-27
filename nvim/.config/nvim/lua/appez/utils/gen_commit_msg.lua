local is_generating = false

local MAX_DIFF_CHARS = 24000

local EXCLUDED_PATTERNS = {
	":!package-lock.json",
	":!pnpm-lock.yaml",
	":!*.lock",
	":!*.sum",
}

local function get_staged_diff()
	-- Get diff excluding lock files
	local args = { "git", "diff", "--cached", "-U2", "--" }
	vim.list_extend(args, EXCLUDED_PATTERNS)

	local diff_obj = vim.system(args, { text = true }):wait()
	if diff_obj.code ~= 0 then
		return nil
	end

	local diff = diff_obj.stdout

	-- If empty (only lock files were staged), use stat summary
	if diff == "" then
		local stat = vim.system({ "git", "diff", "--cached", "--stat" }, { text = true }):wait().stdout or ""

		if stat == "" then
			return nil -- truly nothing staged
		end

		vim.notify("Only lock/generated files staged — using stat summary.", vim.log.levels.WARN)
		return "Only dependency/lock files changed:\n" .. stat
	end

	-- Truncate if still too large
	if #diff > MAX_DIFF_CHARS then
		local stat = vim.system({ "git", "diff", "--cached", "--stat" }, { text = true }):wait().stdout or ""
		diff = "Overview:\n" .. stat .. "\n\nTruncated diff:\n" .. diff:sub(1, MAX_DIFF_CHARS)
		vim.notify("Diff truncated.", vim.log.levels.WARN)
	end

	return diff
end

local function generate_commit_message(model)
	if is_generating then
		vim.notify("Commit message generation is already in progress.", vim.log.levels.WARN)
		return
	end

	local git_diff = get_staged_diff()
	if not git_diff then
		vim.notify("No staged changes. Run 'git add' first.", vim.log.levels.WARN)
		return
	end

	local system_prompt = [[You analyze a provided git diff and output exactly one Conventional Commit message.

STRICT RULES:
1. Output ONLY the raw commit message.
2. Do NOT use markdown, bullets, lists, backticks, headings, bold text, explanations, or code blocks.
3. The first line MUST match this exact format:
   <type>(<scope>): <description>
4. Allowed types are:
   feat, fix, refactor, perf, docs, test, chore, ci, build, style
5. The scope is REQUIRED and must be a short lowercase noun inferred from the diff.
6. If no clear scope exists, use "general".
7. The description must be lowercase, imperative mood, under 50 characters, and have no ending period.
8. For simple changes, output only the first line.
9. For complex changes, add a plain text body after one blank line.
10. The body must be wrapped at 72 characters.
11. The body must explain WHY the change was made, not just WHAT changed.
12. If the diff introduces a breaking change, add "!" before the colon:
    <type>(<scope>)!: <description>
    and include a BREAKING CHANGE: footer.]]

	local payload = vim.json.encode({
		model = model,
		system = system_prompt,
		prompt = git_diff,
		think = false,
		stream = false,
		options = {
			temperature = 0.1, -- keeps the output highly structured and disciplined
			top_p = 0.9, -- allows for some creativity while still being focused
			num_predict = 256, -- limit the length of the commit message
			num_ctx = 8192, -- context window size
		},
	})

	local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local spinner_idx = 1
	local uv = vim.uv or vim.loop
	local timer = uv.new_timer()
	is_generating = true

	timer:start(
		0,
		80,
		vim.schedule_wrap(function()
			vim.api.nvim_echo({ { spinner_frames[spinner_idx] .. " Ollama is thinking...", "WarningMsg" } }, false, {})
			spinner_idx = (spinner_idx % #spinner_frames) + 1
		end)
	)

	-- 5. Call Ollama API asynchronously (Neovim won't freeze!)
	vim.system({
		"curl",
		"-s",
		"-X",
		"POST",
		"http://localhost:11434/api/generate",
		"-H",
		"Content-Type: application/json",
		"-d",
		payload,
	}, { text = true }, function(obj)
		vim.schedule(function()
			is_generating = false
			timer:stop()
			timer:close()
			vim.api.nvim_echo({ { "", "Normal" } }, false, {}) -- Clear echo/status line

			if obj.code ~= 0 then
				vim.notify("Ollama API request failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
				return
			end

			local ok, decoded = pcall(vim.json.decode, obj.stdout)
			if not ok or not decoded or not decoded.response then
				vim.notify("Failed to parse Ollama response.", vim.log.levels.ERROR)
				return
			end

			local commit_message = decoded.response:gsub("^%s*(.-)%s*$", "%1")
			local lines = vim.split(commit_message, "\n")

			vim.api.nvim_buf_set_lines(0, 0, 1, false, lines)
			vim.notify("Commit message generated!", vim.log.levels.INFO)
		end)
	end)
end

local models = {
	{ key = "<leader>c", model = "qwen2.5-coder:1.5b", desc = "Generate commit (fast)" },
	{ key = "<leader>bc", model = "qwen2.5-coder:7b", desc = "Generate commit (big)" },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		for _, entry in ipairs(models) do
			vim.keymap.set("n", entry.key, function()
				generate_commit_message(entry.model)
			end, { buffer = true, desc = entry.desc })
		end
	end,
})
