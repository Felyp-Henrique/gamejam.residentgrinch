local Asset = require('core.assets.asset')

--- Representa um audio no jogo
---
--- @class AudioAsset
--- @field path string caminho do audio
local AudioAsset = Asset:new()

function AudioAsset:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function AudioAsset:is_running()
    return self.__audio:isPlaying()
end

function AudioAsset:start()
    self.__audio:play()
end

function AudioAsset:stop()
    self.__audio:stop()
end

function AudioAsset:load()
    assert(self.path, 'AudioAsset:path não pode ser uma string vazia ou nula')
    self.__audio = love.audio.newSource(self.path, 'static')
end

return AudioAsset