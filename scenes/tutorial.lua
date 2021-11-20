local Scene = require('core.scenes.scene')
local LoveUtils = require('core.utils.love')
local ImageAsset = require('core.assets.image')
local KeysEvent = require('core.events.keys')
local FadeAnimation = require('core.animations.fade')


local TutorialScene = Scene:new {
    alias = 'tutorial',
}

function TutorialScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function TutorialScene:load()
    if not self.loaded then
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
                self.fadeout:stop()
                self.manager:show('cavernas')
            end,
        }
        self.fadeout:load()

        self.keys = KeysEvent:new()

        self.keys:add('return', function()
            self.fadein:stop()
            self.fadeout:start()
        end)

        self.image = ImageAsset:new {
            path = 'assets/pictures/textointrodutorio.png',
        }
        self.image:load()
        self.x = LoveUtils.getCenterX()
        self.y = LoveUtils.getCenterY()
        self.image.ox = 0
        self.image.oy = 0

        self.loaded = true
    end
end

function TutorialScene:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)

    self.fadein:draw()
    self.fadeout:draw()
    self.image:draw()
end

function TutorialScene:update(dt)
    self.fadein:update(dt)
    self.fadeout:update(dt)
end

function TutorialScene:keypressed(key, scancode, isrepeat)
    self.keys:keypressed(key, scancode, isrepeat)
end

return TutorialScene