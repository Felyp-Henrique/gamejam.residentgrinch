--- Estrutura de um ativo estatico do jogo que nao representa um
--- objeto
---
--- @class Asset
--- @field path string caminho do ativo
local Asset = {
    path = nil,
}

--- Instancia um recurso
---
--- @param obj table
--- @return Asset
function Asset:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function Asset:load()
    error('Método Asset:load não foi implementado')
end

return Asset