local Object = require('core.physics.object')
local ImageAsset = require('core.assets.image')
local Area = require('core.physics.area')

--- Objeto de heroi em jogo
---
--- @class HeroObject
local HeroObject = Object:new {
    type = '',
    world = nil,
}

--- Instancia um novo heroi
---
---@param obj table
---@return HeroObject
function HeroObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function HeroObject:load()
    if not self.loaded then
        self.image = ImageAsset:new {
            path = 'assets/sprites/grinch.png',
        }
        self.image:load()
        self.image.ox = self.image.width / 2
        self.image.oy = self.image.height / 2
        self.image.x = self.x
        self.image.y = self.y
        self.image.r = self.r

        self.body = love.physics.newBody(self.world, self.x, self.y, 'static')
        self.body:setMass(80)

        self.shape = love.physics.newRectangleShape(
            self.x,
            self.y,
            self.width,
            self.image.height,
            self.r
        )

        self.fixture = love.physics.newFixture(self.body, self.shape)

        self.loaded = true
    end
end

function HeroObject:draw()
    self.image:draw()
end

function HeroObject:update(dt)
    local x, y, _, _ = self.body:getWorldPoints(self.shape:getPoints())
    self.x = x
    self.y = y
    self.image.x = self.x
    self.image.y = self.y
    self.image.r = self.r
end

return HeroObject