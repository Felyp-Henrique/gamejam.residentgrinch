local Asset = require('core.assets.asset')

local VideoAsset = Asset:new()

function VideoAsset:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function VideoAsset:load()
    assert(self.path, 'AudioAsset:path não pode ser uma string vazia ou nula')
    self.__video = love.graphics.newVideo(self.path)
end

function VideoAsset:draw()
    love.graphics.draw(self.__video, 0, 0)
end

function VideoAsset:start_unique()
    if not self.played then
        print('hello')
        self:start()
        self.played = true
    end
end

function VideoAsset:start()
    self.__video:play()
end

function VideoAsset:stop()
    self.__video:pause()
end

function VideoAsset:is_running()
    return self.__video:isPlaying()
end


return VideoAsset