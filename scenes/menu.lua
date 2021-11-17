local Scene = require('core.scenes.scene')
local ImageAsset = require('core.assets.image')
local LoveUtils = require('core.utils.love')
local KeysEvent = require('core.events.keys')
local FadeAnimation = require('core.animations.fade')
local AudioAsset = require('core.assets.audio')

local MenuScene = Scene:new {
    alias = 'menu',
}

function MenuScene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function MenuScene:load()
    if not self.loaded then
        -- configurar background
        self.background = ImageAsset:new {
            path = 'assets/pictures/menu.png',
        }
        self.background:load()
        self.background.x = LoveUtils.getCenterX()
        self.background.y = LoveUtils.getCenterY()
        self.background.sx = LoveUtils.getScale()
        self.background.sy = LoveUtils.getScale()
        self.background.ox = self.background.width / 2
        self.background.oy = self.background.height / 2

        -- configurar fade in/out
        self.fadein = FadeAnimation:new {
            duration = 3,
        }
        self.fadein:load()
        self.fadein:start()

        self.fadeoutToCreditos = FadeAnimation:new {
            reverse = true,
            duration = 2,
            divisor = 2,
            on_finish = function()
                self.manager:show('creditos')
                self.fadeoutToCreditos:stop()
            end
        }
        self.fadeoutToCreditos:load()

        self.fadeoutToCaves = FadeAnimation:new {
            reverse = true,
            divisor = 5,
            on_finish = function()
                self.fadeoutToCaves:stop()
            end
        }
        self.fadeoutToCaves:load()

        -- configurar audios
        self.audioIntro = AudioAsset:new {
            path = 'assets/audios/intro.ogg',
        }
        self.audioIntro:load()

        -- configurar eventos de teclado
        self.keys = KeysEvent:new()

        self.keys:add('return', function(isrepeat)
            -- tecla: enter
            if not isrepeat then
                self.fadein:stop()
                self.fadeoutToCaves:start()
                self.audioIntro:start()
            end
        end)

        self.keys:add('c', function(isrepeat)
            -- tecla: c
            if not isrepeat then
                self.fadein:stop()
                self.fadeoutToCreditos:start()
            end
        end)

        self.keys:add('escape', function()
            -- tecla: esc
            love.event.quit(0)
        end)

        self.loaded = true
    end
end

function MenuScene:draw()
    -- configurar fade
    self.fadein:draw()
    self.fadeoutToCreditos:draw()
    self.fadeoutToCaves:draw()

    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)

    -- desenhar background
    self.background:draw()
end

function MenuScene:update(dt)
    self.fadein:update(dt)
    self.fadeoutToCreditos:update(dt)
    self.fadeoutToCaves:update(dt)
end

function MenuScene:keypressed(key, scancode, isrepeat)
    self.keys:keypressed(key, scancode, isrepeat)
end

function MenuScene:on_show()
    if self.loaded then
        self.fadein:start()
    end
end

return MenuScene