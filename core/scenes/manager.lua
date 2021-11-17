--- Estrutura para gerenciar cenas do jogo
---
--- @class SceneManager
--- @field scenes table[] lista de cenas
--- @field showing string cena em exibicao
local SceneManager = {
    showing = '',
    scenes = {},
}

--- Instancia uma nova cena
---
--- @return SceneManager
function SceneManager:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

--- Adiciona um nova cena ao gerenciador
---
--- @param alias string
--- @param scene table
function SceneManager:add(alias, scene)
    self.scenes[alias] = scene
    self.scenes[alias]:load()
end

--- Retorna uma cena ou a cena em exibicao
---
--- @param alias? string apelido da cena
--- @return table
function SceneManager:get(alias)
    return self.scenes[alias or self.showing]
end

--- Muda a cena que sera exibida
---
--- @param alias string apelido da cena
function SceneManager:show(alias)
    self.showing = alias
    if self.scenes[self.showing]['on_show'] then
        self.scenes[self.showing]:on_show()
    end
end

return SceneManager