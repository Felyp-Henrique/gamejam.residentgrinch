local Scene = require('core.scenes.scene')
local ImageAsset = require('core.assets.image')
local LoveUtils = require('core.utils.love')
local FadeAnimation = require('core.animations.fade')
local KeysEvent = require('core.events.keys')

local CreditosScene = Scene:new {
    alias = 'creditos',
}

function CreditosScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function CreditosScene:load()
    if not self.loaded then
        -- configurar background
        self.background = ImageAsset:new {
            path = 'assets/pictures/creditos.png',
        }
        self.background:load()
        self.background.x = LoveUtils.getCenterX()
        self.background.y = LoveUtils.getCenterY()
        self.background.sx = LoveUtils.getScale()
        self.background.sy = LoveUtils.getScale()
        self.background.ox = self.background.width / 2
        self.background.oy = self.background.height / 2

        -- configurar fades
        self.fadein = FadeAnimation:new {
            duration = 2,
            divisor = 2,
        }
        self.fadein:load()
        self.fadein:start()

        self.fadeout = FadeAnimation:new {
            reverse = true,
            duration = 2,
            divisor = 2,
            on_finish = function ()
                self.manager:show('menu')
                self.fadeout:stop()
            end
        }
        self.fadeout:load()

        -- configurar keys
        self.keys = KeysEvent:new()

        self.keys:add('return', function()
            self.fadeout:start()
        end)

        self.loaded = true
    end
end

function CreditosScene:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)
    self.fadein:draw()
    self.fadeout:draw()
    self.background:draw()
end

function CreditosScene:update(dt)
    self.fadein:update(dt)
    self.fadeout:update(dt)
end

function CreditosScene:keypressed(key, scancode, isrepeat)
    self.keys:keypressed(key, scancode, isrepeat)
end

function CreditosScene:on_show()
    if self.loaded then
        self.fadein:start()
    end
end

return CreditosScene