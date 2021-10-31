local Image = require('core.image')

FogEffect = {}

function FogEffect:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.picture = nil
    self.match = nil
    self.timer = 0
    return obj
end

function FogEffect:load()
    if not self.picture then
        self.picture = Image:new()
        self.picture.path = 'assets/pictures/fog_normal.png'
    end
    self.picture.x = (love.graphics.getWidth() / 2)
    self.picture.y = (love.graphics.getHeight() / 2)
    self.picture.sx = 1
    self.picture.sy = 1
    self.picturealpha = 0
    self.picture.oy = (self.picture.height / 2) -- problema! por conta dos spritesheets
    -- load() carrega valor incorreto em picture.x poré é correto para os spritsheets
    self.picture:load()
    -- sobreescrever ox
    self.picture.ox = self.picture.width / 2
end

function FogEffect:draw()
    love.graphics.setColor(1, 1, 1, self.picturealpha)
    love.graphics.draw(
        self.picture.image,
        self.picture.x, self.picture.y,
        self.picture.r,
        self.picture.sx, self.picture.sy,
        self.picture.ox, self.picture.oy
    )
end

function FogEffect:update(dt)
    self.timer = self.timer + dt
    local delta = self.match.fogalphadelta
    if self.timer > 0.5 then
        if ((self.picturealpha + delta) >= 0) and ((self.picturealpha+delta) < 1) then
            self.picturealpha = self.picturealpha + delta
        end
        self.timer = 0
    end
end

return FogEffect