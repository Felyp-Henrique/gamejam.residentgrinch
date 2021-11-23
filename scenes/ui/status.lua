local Component = require('core.ui.component')

--- Representa o placar do game
---
--- @class StatusComponent
local StatusComponent = Component:new {
    life = 100,
    points = 0,
}

--- Instancia um novo Status
---
--- @param obj table
--- @return StatusComponent
function StatusComponent:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function StatusComponent:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('Vida: ' .. tostring(self.life), 10, 10)
    love.graphics.print('Pontos: ' .. tostring(self.points), 10, 30)
end

return StatusComponent