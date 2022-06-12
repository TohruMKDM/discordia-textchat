--[=[
@c GuildVoiceChannel x GuildChannel x TextChannel
@d Represents a voice channel in a Discord guild, where guild members can connect
and communicate via voice chat.
]=]

local discordia = require('discordia')

local TextChannel = discordia.class.classes.TextChannel
local GuildChannel = discordia.class.classes.GuildChannel

local GuildVoiceChannel = discordia.class.classes.GuildVoiceChannel
local get = GuildVoiceChannel.__getters

GuildVoiceChannel.__bases[#GuildVoiceChannel.__bases + 1] = TextChannel

local allowed = {broadcastTyping = true, getFirstMessage = true, getLastMessage = true, getMessage = true, getMessages = true, getMessagesAfter = true, getMessagesAround = true, getMessagesBefore = true, send = true, sendf = true}

local old = GuildVoiceChannel.__init
function GuildVoiceChannel:__init(data, parent)
	old(self, data, parent)
	TextChannel.__init(self, data, parent)
end

function GuildVoiceChannel:_load(data)
	GuildChannel._load(self, data)
	TextChannel._load(self, data)
end

for k, v in pairs(TextChannel) do
	if allowed[k] then
		GuildVoiceChannel[k] = v
	end
end

-- Bad doc comment? idk im tired
--[=[@p textEnabled boolean Whether this voice channel has a text channel attached to it.]=]
function get.textEnabled(self)
	-- Unsure if guilds can disable this feature after enabling it so check each time
	--[[
	if not self._textEnabled then
		local textEnabled = false
		for _, feature in ipairs(self._parent._features) do
			if feature == 'TEXT_IN_VOICE_ENABLED' then
				textEnabled = true
				break
			end
		end
		self._textEnabled = textEnabled
	end
	return self._textEnabled
	]]
	local textEnabled = false
	for _, feature in ipairs(self._parent._features) do
		if feature == 'TEXT_IN_VOICE_ENABLED' then
			textEnabled = true
			break
		end
	end
	return textEnabled
end

return GuildVoiceChannel