local Scene = require('core.scenes.scene')
local FadeAnimation = require('core.animations.fade')
local VideoAsset = require('core.assets.video')

local EquipeScene = Scene:new {
    alias = 'equipe',
}

function EquipeScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function EquipeScene:load()
    if not self.loaded then
        self.fadein = FadeAnimation:new {
            duration = 2,
            divisor = 2,
            on_finish = function()
                self.fadein:stop()
            end,
        }
        self.fadein:load()
        self.fadein:start()

        self.fadeout = FadeAnimation:new {
            reverse = true,
            duration = 2,
            divisor = 2,
            on_finish = function()
                self.manager:show('menu')
            end,
        }
        self.fadeout:load()

        self.video = VideoAsset:new {
            path = 'assets/movies/introDrafts04nonPixelrev02.ogv',
        }
        self.video:load()

        self.loaded = true
    end
end

function EquipeScene:draw()
    self.fadein:draw()
    self.fadeout:draw()
    self.video:draw()
end

function EquipeScene:update(dt)
    self.fadein:update(dt)
    self.fadeout:update(dt)
    self.video:start_unique()
    if not self.video:is_running() then
        self.fadeout:start()
    end
end

return EquipeScene