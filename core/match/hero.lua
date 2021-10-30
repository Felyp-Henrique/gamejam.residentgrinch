local Image = require('core.image')

Hero = {}

function Hero:new(values)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.nick = values.nick or ""
    self.life = values.life or 100
    self.force = values.force or 20
    self.r = 0
    self.sx = 0
    self.sy = 0
    self.sprite = values.sprite or nil
    return obj
end

-- metodos principais

function Hero:attack(enemy)
    enemy:bleed(self.force)
end

function Hero:bleed(force)
    self.life = self.life - force
end

-- helpers

function Hero:getPostion()
    -- local x = (love.graphics.getWidth() / 2) - (self.sprite.image:getWidth() / 2)
    -- local y = (love.graphics.getHeight() / 2) - (self.sprite.image:getHeight() / 2)
    local x = (love.graphics.getWidth() / 2) - 20
    local y = (love.graphics.getHeight() / 2) - 20
    return x, y
end

-- metodos para o love

function Hero:load()
    if not self.sprite then
        self.sprite = Image:new('assets/sprites/hero.png')
        self.sprite:load()
    else
        self.sprite:load()
    end
    self.sx = 1
    self.sy = 1
end

function Hero:update(dt)
    local x, y = self:getPostion()
    self.r = math.atan2(love.mouse.getX() - x, y - love.mouse.getY())
end

function Hero:draw()
    local x, y = self:getPostion()
    love.graphics.draw(
        self.sprite.image,
        x,
        y,
        self.r,
        self.sx,
        self.sy,
        32,
        32
    )
end

return Hero