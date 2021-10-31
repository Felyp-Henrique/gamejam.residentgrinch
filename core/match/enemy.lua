local Image = require('core.image')

Enemy = {}

function Enemy:new(values)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.nick = values.nick or ""
    self.life = values.life or 100
    self.points = values.points or 0
    self.force = values.force or 20
    self.x = values.x or 0
    self.y = values.y or 0
    self.r = values.r or 0
    self.sx = 0
    self.sy = 0
    self.sprite = values.sprite or nil
    return obj
end

-- metodos principais

function Enemy:danger(force)
    self.life = self.life - force
end

function Enemy:move(x, y)
    self.x = x or self.x
    self.y = y or self.y
end

-- metodos para o love

function Enemy:load()
    if not self.sprite then
        self.sprite = Image:new('assets/sprites/hero.png')
        self.sprite:load()
    else
        self.sprite:load()
    end
    self.sx = 1
    self.sy = 1
end

function Enemy:update(dt)
end

function Enemy:draw()
    love.graphics.draw(
        self.sprite.image,
        self.x,
        self.y,
        self.r,
        self.sx,
        self.sy,
        40,
        40
    )
end

return Enemy