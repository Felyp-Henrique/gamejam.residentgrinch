local Object = require('core.physics.object')
local ImageAsset = require('core.assets.image')
local State = require('core.physics.state')
local Area = require('core.physics.area')

--- Representa um projetil(pedra, tiro, etc) em jogo
---
--- @class ProjectileObject
local ProjectileObject = Object:new {
    state = State.moving,
    area = nil,
    world = nil,
}

--- Instancia um novo projetil
---
--- @param obj table
--- @return ProjectileObject
function ProjectileObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function ProjectileObject:load()
    if not self.loaded then
        self.image = ImageAsset:new {
            path = 'assets/sprites/projectile.png',
        }
        self.image:load()

        self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
        self.body:setMass(10)

        self.shape = love.physics.newRectangleShape(
            self.x,
            self.y,
            self.image.width,
            self.image.height,
            self.r
        )

        self.fixture = love.physics.newFixture(self.body, self.shape)

        self.loaded = true
    end
end

function ProjectileObject:draw()
    love.graphics.draw(
        self.image.__image,
        self.x,
        self.y,
        self.r,
        self.sx,
        self.sy,
        3,
        3
    )
end

function ProjectileObject:update(dt)
    self.x = self.x + math.cos(self.direction) * 200 * dt
    self.y = self.y + math.sin(self.direction) * 200 * dt

    -- self.shape = love.physics.newRectangleShape(
    --         self.x,
    --         self.y,
    --         self.image.width,
    --         self.image.height,
    --         self.r
    --     )

    -- self.fixture = love.physics.newFixture(self.body, self.shape)
end

return ProjectileObject