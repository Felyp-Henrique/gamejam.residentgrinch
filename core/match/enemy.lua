local Image = require('core.image')

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
    else
        texto =  self.sprite:load()
        texto = texto .. " " .. tostring(self.sprite.width) .. " " .. tostring(self.sprite.height)
    end
    self.sx = 1
    self.sy = 1


    -- ANIMACAO
    animation = newAnimation(self.sprite, 32, 32, 4)
end

function Enemy:update(dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
    
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

    -- ANIMACAO
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], self.x, self.y, 0, 2)
end

-- ANIMACAO
function newAnimation(sprite, width, height, duration)
    local animation = {}
    animation.spriteSheet = sprite.image;
    animation.quads = {};

    for y = 0, sprite.height - height,  height do
        for x = 0, sprite.width - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, sprite.image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end


return Enemy