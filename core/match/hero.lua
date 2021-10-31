local Image = require('core.image')

Hero = {}

function Hero:new(values)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.nick = values.nick or ""
    self.life = values.life or 100
    self.r = 0
    self.sx = 1
    self.sy = 1
    self.sprite = values.sprite
    return obj
end

-- metodos principais

function Hero:danger(force)
    self.life = self.life - force
end

-- metodos para o love

function Hero:load()
    if not self.sprite then
        self.sprite = Image:new('assets/sprites/hero.png')
        self.sprite:load()
    else
        self.sprite:load()
    end
end

function Hero:update(dt)
    local x, y = self:__getPostion()
    self.r = math.atan2(love.mouse.getX() - x, y - love.mouse.getY())
end

function Hero:draw()
    local x, y = self:__getPostion()
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

function Hero:mousepressed(x, y, button)
end

-- helpers

function Hero:__getPostion()
    local x = (love.graphics.getWidth() / 2) - 20
    local y = (love.graphics.getHeight() / 2) - 20
    return x, y
end

return Hero