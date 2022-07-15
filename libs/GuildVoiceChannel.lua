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

local blacklist = {getPinnedMessages = true}

function GuildVoiceChannel:__init(data, parent)
	GuildChannel.__init(self, data, parent)
	TextChannel.__init(self, data, parent)
end

function GuildVoiceChannel:_load(data)
	GuildChannel._load(self, data)
	TextChannel._load(self, data)
end

for name, method in pairs(TextChannel) do
	if not blacklist[name] then
		GuildVoiceChannel[name] = method
	end
end

for name, getter in pairs(TextChannel.__getters) do
	get[name] = getter
end

function get.textEnabled(self)
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