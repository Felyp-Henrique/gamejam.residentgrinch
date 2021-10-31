--
-- projetil arremecado pelo heroi
--

Projectile = {}

function Projectile:new(values)
    local obj = {}
    values = values or {}
    setmetatable(obj, self)
    self.__index = self
    self.x = values.x or 0
    self.y = values.y or 0
    self.direction = values.direction or 0
    self.r = values.r or 0
    self.sx = values.sx or 1
    self.sy = values.sy or 1
    self.sprite = values.sprite
    self.timer = 0
    return obj
end

-- metodos do love

function Projectile:load()
    if not self.sprite then
        self.sprite = Image:new("assets/sprites/projectile.png")
        self.sprite:load()
    else
        self.sprite:load()
    end
end

function Projectile:draw()
    love.graphics.draw(
        self.sprite.image,
        self.x,
        self.y,
        self.r,
        self.sx,
        self.sy,
        3,
        3
    )
end

function Projectile:update(dt)
    self.x = self.x + math.cos(self.direction) * 200 * dt
    self.y = self.y + math.sin(self.direction) * 200 * dt
end

return Projectile