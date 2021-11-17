local Scene = require('core.scenes.scene')
local ImageAsset = require('core.assets.image')
local KeysEvent = require('core.events.keys')

local GameOverScene = Scene:new {
    alias = 'gameover',
}

function GameOverScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function GameOverScene:load()
    if not self.loaded then
        self.image = ImageAsset:new {
            path = 'assets/pictures/gameover.png',
        }
        self.image:load()

        self.keys = KeysEvent:new()
        self.keys:add('return', function()
            self.manager:show('menu')
        end)

        self.loaded = true
    end
end

function GameOverScene:draw()
    self.image:draw()
end

function GameOverScene:keypressed(key, scancode, isrepeat)
    self.keys:keypressed(key, scancode, isrepeat)
end

return GameOverScene