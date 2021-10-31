local Image = require('core.image')
local Match = require('core.match.match')
local Status = require('core.ui.status')

BattlefieldScene = {}

function BattlefieldScene:new(manager)
    assert(manager ~= nil, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    self.match = Match:new { manager = manager }
    self.status = nil
    return obj
end

-- metodos principais

function BattlefieldScene:load()
    self.fog = Image:new('assets/pictures/fogofwarrev03.png')
    -- self.fog.x = (love.graphics.getWidth() / 2) - (self.fog.width / 2)
    -- self.fog.y = (love.graphics.getHeight() / 2) - (self.fog.height / 2)
    self.fog.x = (love.graphics.getWidth() / 2)
    self.fog.y = (love.graphics.getHeight() / 2)
    self.fog.sx = 1
    self.fog.sy = 1
    self.fogalpha = 0
    -- self.fog.ox = (self.fog.width / 2)
    self.fog.oy = (self.fog.height / 2) -- problema! por conta dos spritesheets
    -- load() carrega valor incorreto em fog.x poré é correto para os spritsheets
    self.fog:load()
    -- sobreescrever ox
    self.fog.ox = self.fog.width / 2
    self.match:load()
    self.status = Status:new(self.match)
end

function BattlefieldScene:draw()
    self.match:draw()
    love.graphics.setColor(1,1,1,self.fogalpha)
    love.graphics.draw(self.fog.image, 
        self.fog.x, self.fog.y,   
        self.fog.r,
        self.fog.sx, self.fog.sy,
        self.fog.ox, self.fog.oy)

    love.graphics.setColor(1,1,1,1)
    self.status:draw()
end

function BattlefieldScene:update(dt)
    self.match:update(dt)
    self:updatefog()
    self.status.match = self.match
end

function BattlefieldScene:keypressed(key, scancode, isrepeat)
    if key == 'return' then
        self.match:gameOver()
    end
end

function BattlefieldScene:mousepressed(x, y, button)
    self.match:mousepressed(x, y, button)

end

function BattlefieldScene:updatefog()
    local delta = self.match.fogalphadelta

    if ((self.fogalpha + delta) >= 0) and ((self.fogalpha+delta) < 2) then
        self.fogalpha = self.fogalpha + delta
    end
end

return BattlefieldScene