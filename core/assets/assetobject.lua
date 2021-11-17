local Object = require('core.physics.object')

--- Estrutura de um ativo estatico como objeto do jogo
---
--- @class AssetObject
--- @field x number posicao do objeto no eixo x
--- @field y number posicao do objeto no eixo y
--- @field r number rotacao do objeto
--- @field sx number escala em x
--- @field sy number escala em y
--- @field ox number ponto de origem x
--- @field oy number ponto de origem y
--- @field width number representa a largura do objeto
--- @field height number representa a altura do objeto
--- @field state State estado em que o objeto esta
--- @field path string caminho do ativo
---
--- @see Object
local AssetObject = Object:new {
    path = nil,
}

--- Instancia um recurso
---
--- @param obj table
--- @return AssetObject
function AssetObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function AssetObject:load()
    error('Método AssetObject:load não foi implementado')
end

return AssetObject