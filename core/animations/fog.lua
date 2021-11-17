local Animation = require('core.animations.animation')

--- Animacao de Fog
---
--- @class FogAnimation
--- @field alias string
--- @field alpha number
--- @field interval number intervalo de tempo para update da animacao
--- @field duration number duracao em segundos
--- @field loaded boolean
--- @field asset ImageAsset
--- @field delta number
local FogAnimation = Animation:new {
    alias = 'fog_animation',
    asset = nil,
    alpha = 0,
    interval = 0.5,
    duration = 30,
    delta = 0.005,
}

function FogAnimation:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function FogAnimation:on_load()
    if not self.loaded then
        assert(self.asset, 'Asset não pode ser nulo')
        -- configurar asset
        self.asset:load()
        self.asset.ox = self.asset.width / 2
        self.asset.oy = self.asset.height / 2
        self.loaded = true
    end
end

function FogAnimation:on_draw()
    love.graphics.setColor(1, 1, 1, self.alpha)
    self.asset:draw()
end

function FogAnimation:on_interval(timer, dt)
    if self.alpha >= 0 and self.alpha <= 1 then
        self.alpha = self.alpha + 0.1
    end
end

return FogAnimation