--
-- projetil arremecado pelo heroi
--

Projectile = {}

function Projectile:new(values)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.x = values.x or 0
    self.y = values.y or 0
    self.r = values.r or 0
    self.sx = values.sx or 0
    self.sy = values.sy or 0
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
    love.graphics.rotate(-math.pi / 2)
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
    self.timer = self.timer + dt
end

return Projectile