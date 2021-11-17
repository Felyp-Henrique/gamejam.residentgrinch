local Object = require('core.physics.object')
local State = require('core.physics.state')
local Area = require('core.physics.area')

--- Objeto de inimigo em jogo
---
--- @class EnemyObject
local EnemyObject = Object:new {
    state = State.moving,
    area = Area:new(),
}

--- Instancia um novo inimigo
---
--- @param obj table
--- @return EnemyObject
function EnemyObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return EnemyObject