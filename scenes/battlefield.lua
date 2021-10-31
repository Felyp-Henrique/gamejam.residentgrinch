local Image = require('core.image')
local Match = require('core.match.match')

BattlefieldScene = {}

function BattlefieldScene:new(manager)
    assert(manager ~= nil, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    self.match = Match:new { manager = manager }
    return obj
end

-- metodos principais

function BattlefieldScene:load()
    self.fog = Image:new('assets/pictures/fog.png')
    self.fog.x = (love.graphics.getWidth() / 2) - (self.fog.width / 2)
    self.fog.y = (love.graphics.getHeight() / 2) - (self.fog.height / 2)
    self.fog.sx = 0.9
    self.fog.sy = 0.9
    self.fog:load()
    self.match:load()
end

function BattlefieldScene:draw()
    self.match:draw()
end

function BattlefieldScene:update(dt)
    self.match:update(dt)
end

function BattlefieldScene:keypressed(key, scancode, isrepeat)
    if key == 'return' then
        self.match:gameOver()
    end
end

return BattlefieldScene