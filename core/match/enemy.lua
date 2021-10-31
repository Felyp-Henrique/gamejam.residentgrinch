local Image = require('core.image')
local anim8 = require('core.anim8')

Enemy = {}

function Enemy:new(values)
    values = values or {}
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
    texto = ""
    if not self.sprite then
        self.sprite = Image:new('assets/sprites/hero.png')
        self.sprite:load()
    end
    self.sprite:load()

    self.sx = 1
    self.sy = 1

    -- ANIM8
    local g = anim8.newGrid(32, 32, self.sprite.width, self.sprite.height)
    animation = anim8.newAnimation(g('1-4',1), 0.25)

end

function Enemy:update(dt)
    -- ANIM8
    animation:update(dt)
end

function Enemy:draw()
    --[[
    love.graphics.draw(
        self.sprite.image,
        self.x,
        self.y,
        self.r,
        self.sx,
        self.sy,
        40,
        40
    )--]]

    -- ANIM8
    animation:draw(self.sprite.image,self.x,self.y,self.r,self.sx,self.sy,40,40)
    love.graphics.setColor(0,0,0,1)
    love.graphics.print("t: " .. texto .. tostring(self.sprite.width) .. " " .. tostring(self.sprite.height), 10, 10)
end



return Enemy