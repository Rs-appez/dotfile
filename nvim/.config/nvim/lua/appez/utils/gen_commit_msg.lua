local function generate_commit_message(model)
	local diff_obj = vim.system({ "git", "diff", "--cached" }, { text = true }):wait()
	if diff_obj.code ~= 0 or diff_obj.stdout == "" then
		vim.notify("No staged changes to commit. Run 'git add' first.", vim.log.levels.WARN)
		return
	end
	local git_diff = diff_obj.stdout

	local system_prompt =
		[[You are an expert developer assistant. Your sole task is to analyze the provided git diff and write a concise commit message.

STRICT RULES:
1. Output ONLY the raw commit message. Do NOT write any introduction, markdown formatting, backticks, explanation, or code blocks.
2. Format using Conventional Commits: <type>(<scope>): <description>
3. Keep the title (first line) under 50 characters, lowercase, in the imperative mood (e.g., 'fix bug' instead of 'fixed bug'). No ending period.
4. If changes are complex, add a body separated by a blank line, wrapped at 72 characters. Focus on WHY the change was made, not just WHAT changed.]]

	local payload = vim.json.encode({
		model = model,
		system = system_prompt,
		prompt = git_diff,
		stream = false,
		options = {
			temperature = 0 - 0.2, -- keeps the output highly structured and disciplined
			top_p = 0.9, -- allows for some creativity while still being focused
			max_tokens = 256, -- limit the length of the commit message
		},
	})

	local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local spinner_idx = 1
	local uv = vim.uv or vim.loop
	local timer = uv.new_timer()

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

			vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
			vim.notify("Commit message generated!", vim.log.levels.INFO)
		end)
	end)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.keymap.set("n", "<leader>c", function()
			local model = "qwen2.5-coder:1.5b"
			generate_commit_message(model)
		end, { buffer = true, desc = "Generate commit message with CopilotChat" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.keymap.set("n", "<leader>bc", function()
			local model = "qwen2.5-coder:7b"
			generate_commit_message(model)
		end, { buffer = true, desc = "Generate commit message with CopilotChat" })
	end,
})
