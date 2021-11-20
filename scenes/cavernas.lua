local Scene = require('core.scenes.scene')
local ImageAsset = require('core.assets.image')
local LoveUtils = require('core.utils.love')
local KeysEvent = require('core.events.keys')
local MouseEvent = require('core.events.mouse')
local FadeAnimation = require('core.animations.fade')
local AudioAsset = require('core.assets.audio')

local CavernasScene = Scene:new {
    alias = 'cavernas',
}

function CavernasScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function CavernasScene:load()
    if not self.loaded then
        self.timer = 0

        self.chao = ImageAsset:new {
            path = 'assets/tiles/caves/floor.png',
        }
        self.chao:load()
        self.chao.x = 0
        self.chao.y = 0
        self.chao.r = 0
        self.chao.sx = 0
        self.chao.sy = 0

        self.som_gotas = AudioAsset:new {
            path = 'assets/audios/ambiente_gota.ogg',
        }
        self.som_gotas:load()

        self.som_vento = AudioAsset:new {
            path = 'assets/audios/ambiente_vento.ogg',
        }
        self.som_vento:load()

        self.loaded = true
    end
end

function CavernasScene:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)
    love.graphics.setColor(1, 1, 1, 1)

    self.chao:draw()
end

function CavernasScene:update(dt)
    self.timer = self.timer + dt
    if self.timer >= 5 then
        self.som_gotas:loop()
        self.timer = 0
    elseif self.timer >= 2 then
        self.som_vento:loop()
    end
end


function CavernasScene:keypressed(key, scancode, isrepeat)
end

function CavernasScene:mousepressed(x, y, button)
end

return CavernasScene