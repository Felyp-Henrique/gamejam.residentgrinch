local Image = require('core.image')
local Projectile = require('core.match.projectile')

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
    self.ox = 24
    self.oy = 24
    self.sprite = values.sprite
    self.projectiles = {}
    return obj
end

-- metodos principais

function Hero:danger(force)
    self.life = self.life - force
end

-- metodos para o love

function Hero:load()
    if not self.sprite then
        self.sprite = Image:new('assets/sprites/grinch.png')
        self.sprite:load()
        self.ox = self.sprite.width / 2 -- centralizar na tela
        self.ox = self.sprite.height / 2
    else
        self.sprite:load()
    end
    self:__configMouse()
end

function Hero:update(dt)
    -- atualizar rotacao do heroi
    local x, y = self:__getPostion()
    self.r = math.atan2(love.mouse.getX() - x, y - love.mouse.getY())

    -- atualizar projetiles
    for i, proj in ipairs(self.projectiles) do
        local x, y = self:__getPostion()
        local valor = distancia(
            x,
            y,
            proj.x,
            proj.y
        )
        if valor > 600 then
            table.remove(self.projectiles, i)
        else
            proj:update(dt)
        end
    end
end

function Hero:draw()
    for _, proj in ipairs(self.projectiles) do
        proj:draw()
    end

    local x, y = self:__getPostion()

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(
        self.sprite.image,
        x,
        y,
        self.r,
        self.sx,
        self.sy,
        self.ox,
        self.oy
    )
end

function Hero:mousepressed(x, y, button)
    local handler = self.mouse[button]
    if self.mouse[button] then
        handler()
    end
end

-- helpers

function Hero:__getPostion()
    local x = (love.graphics.getWidth() / 2)
    local y = (love.graphics.getHeight() / 2)
    return x, y
end

function Hero:__configMouse()
    self.mouse = {}
    self.mouse[1] = function()
        local x1, y1 = self:__getPostion()
        local direction1 = math.atan2(love.mouse.getY() - y1, love.mouse.getX() - x1)
        local proj = Projectile:new()
        proj.x = x1
        proj.y = y1
        proj.direction = direction1
        proj:load()
        table.insert(self.projectiles, proj)
    end
end

function distancia(x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

return Hero