# discordia-text
discordia-text is a very simple extension library that makes sending and recieving messages from text chat in voice channels possible.

# Installation
Get this library from [lit](https://luvit.io/lit.html) with the following command
```
lit install TohruMKDM/discordia-textchat
```

# Information
GuildVoiceChannels now inherit the TextChannel class. This means any property or method that is part of the TextChannel class is now part of GuildVoiceChannels.
For example, you can now use methods like `:send()` on voice channel objects.

# Additions
The GuildVoiceChannel class has a new property `textEnabled`
This property will be either `true` or `false` if text chat is enabled in this voice channel.

# Example
```lua
client:on('messageCreate', function(message)
    if message.content == '!test' then
        local voiceChannel = message.guild.voiceChannels:find(function(channel)
            return channel.name == 'General'
        end)
        if voiceChannel.textEnabled then
            voiceChannel:send('working!')
        end
    end
end)
```

# Note
While these new text chats in voice channels are very similar to actual text channels, it is important to note that they are not 1:1.
For example, they do not support pinned messages so the `getPinnedMessages` method is nil.