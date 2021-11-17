local State = require('core.physics.state')

--- Estrutura de objeto de jogo
---
--- @class Object
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
local Object = {
    x = 0,
    y = 0,
    r = 0,
    sx = 1,
    sy = 1,
    ox = nil,
    oy = nil,
    width = 0,
    height = 0,
    state = State.stopped,
}

--- Instancia um novo object
---
--- @param obj table configurar objeto
--- @return Object
function Object:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return Object