local Scene = require('core.scenes.scene')
local MathUtil = require('core.utils.math')
local LoveUtils = require('core.utils.love')
local AudioAsset = require('core.assets.audio')
local ImageAsset = require('core.assets.image')
local FadeAnimation = require('core.animations.fade')

local LoveScene = Scene:new {
    alias = 'love',
}

function LoveScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function LoveScene:load()
    if not self.loaded then
        self.audio = AudioAsset:new {
            path = 'assets/audios/madewithlove_R_Rev0'
                .. tostring(math.floor(MathUtil.random(1.5, 2.5)))
                .. '.ogg',
        }
        self.audio:load()

        self.fadein = FadeAnimation:new {
            divisor = 2,
            duration = 2,
            on_finish = function()
                self.fadein:stop()
                self.fadeout:start()
            end,
        }
        self.fadein:load()
        self.fadein:start()

        self.fadeout = FadeAnimation:new {
            reverse = true,
            divisor = 2,
            duration = 2,
            on_finish = function()
                self.fadeout:stop()
                self.manager:show('menu')
            end,
        }
        self.fadeout:load()

        self.image = ImageAsset:new {
            path = 'assets/pictures/love2d_logo_rev01.png',
        }
        self.image:load()
        self.image.x = LoveUtils.getCenterX() - (self.image.width / 2)
        self.image.y = LoveUtils.getCenterY() - (self.image.height / 2)

        self.loaded = true
    end
end

function Scene:draw()
    love.graphics.setColor(1, 1, 1, 1)
    self.fadein:draw()
    self.fadeout:draw()
    self.image:draw_only_xy()
end

function Scene:update(dt)
    self.fadein:update(dt)
    self.fadeout:update(dt)
    self.audio:start_unique()
end

return LoveScene