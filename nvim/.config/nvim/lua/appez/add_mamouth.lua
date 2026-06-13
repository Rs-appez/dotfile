require("CopilotChat.config").providers.mammouth = {
	prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
	prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

	get_url = function(opts)
		return "https://api.mammouth.ai/v1/chat/completions"
	end,
	get_headers = function()
		local token = assert(os.getenv("MAMMOUTH_API_KEY"), "MAMMOUTH_API_KEY environment variable is not set")
		return {
			["Authorization"] = "Bearer " .. token,
			["Content-Type"] = "application/json",
		}
	end,
	get_models = function(headers)
		local response, err = require("CopilotChat.utils.curl").get("https://api.mammouth.ai/v1/models", {
			headers = headers,
			json_response = true,
		})
		if err then
			error(err)
		end
		return vim.iter(response.body.data)
			:filter(function(model)
				local exclude_patterns = {
					"audio",
					"babbage",
					"dall%-e",
					"davinci",
					"embedding",
					"image",
					"moderation",
					"realtime",
					"transcribe",
					"tts",
					"whisper",
				}
				for _, pattern in ipairs(exclude_patterns) do
					if model.id:match(pattern) then
						return false
					end
				end
				return true
			end)
			:map(function(model)
				return {
					id = model.id,
					name = model.id,
				}
			end)
			:totable()
	end,
}
