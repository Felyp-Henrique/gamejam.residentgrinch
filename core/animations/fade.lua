local Animation = require('core.animations.animation')

--- Animacao de Fade In/Out
---
--- @class FadeAnimation
--- @field alias string
--- @field alpha number nao usar, valor sera sobrescrito no on_load
--- @field interval number intervalo de tempo para update da animacao
--- @field duration number duracao em segundos
--- @field loaded boolean
--- @field reverse boolean se true entao incrementa alpha(fade in), se false, decremeta(fade out)
--- @field divisor number divisor para incremento/decremento
local FadeAnimation = Animation:new {
    alias = 'fade_animation',
    interval = 0,
    duration = 5,
    reverse = false,
    divisor = 3,
}

function FadeAnimation:new(obj)
    self.__index = self
    return setmetatable(obj, self)
end

function FadeAnimation:on_load()
    self.__fadeTimer = 0
    self.__fade = 0
    if not self.reverse then
        self.alpha = 0
    else
        self.alpha = 1
    end
end

function FadeAnimation:on_draw()
    if self:is_running() then
        love.graphics.setColor(1, 1, 1, self.alpha)
    end
end

function FadeAnimation:on_interval(timer, dt)
    self.__fadeTimer = self.__fadeTimer + dt
    self.__fade = self.__fadeTimer / self.divisor
    if not self.reverse then
        self.alpha = self.__fade
    else
        self.alpha = 1 - self.__fade
    end
end

return FadeAnimation