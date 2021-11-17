--- Estrutura de cena do jogo
---
--- @class Scene
--- @field alias string apelido para cena
--- @field manager SceneManager gerenciador de cenas
--- @field loaded boolean flag para sinalizar que recursos foram carregados
local Scene = {
    alias = '',
    manager = nil,
    loaded = false,
}

--- Instancia uma nova cena
---
--- @param obj table
--- @return Scene
function Scene:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function Scene:load()
end

function Scene:draw()
end

function Scene:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
end

function love.mousepressed(x, y, button)
end

return Scene