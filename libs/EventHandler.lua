local function warning(client, object, id, event)
	return client:warning('Uncached %s (%s) on %s', object, id, event)
end
local function getChannel(client, id)
	local guild = client._channel_map[id]
	if guild then
		return guild._text_channels:get(id) or guild._voice_channels:get(id)
	else
		return client._private_channels:get(id) or client._group_channels:get(id)
	end
end

local EventHandler = {}

function EventHandler.MESSAGE_CREATE(d, client)
	local channel = getChannel(client, d.channel_id)
	if not channel then return warning(client, 'TextChannel', d.channel_id, 'MESSAGE_CREATE') end
	local message = channel._messages:_insert(d)
	return client:emit('messageCreate', message)
end

return EventHandler