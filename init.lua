local discordia = require('discordia')
local EventHandler = require('EventHandler')

do
    local client = discordia.Client({logFile = ''})
    client._events.MESSAGE_CREATE = EventHandler.MESSAGE_CREATE
end

require('GuildVoiceChannel')

return true