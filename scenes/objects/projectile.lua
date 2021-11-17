local Object = require('core.physics.object')
local State = require('core.physics.state')
local Area = require('core.physics.area')

--- Representa um projetil(pedra, tiro, etc) em jogo
---
--- @class ProjectileObject
local ProjectileObject = Object:new {
    state = State.moving,
    area = Area:new(),
}

--- Instancia um novo projetil
---
--- @param obj table
--- @return ProjectileObject
function ProjectileObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return ProjectileObject