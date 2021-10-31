local Match = require('core.match.match')
local Status = require('core.ui.status')
local FogEffect require('core.effects.fog')
local Image = require('core.image')

CavesScene = {}

function CavesScene:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.effects = {}
    self.status = nil
    self.layers = {}
    self.match = nil
    self.scene = nil
    return obj
end

-- metodos love

function CavesScene:load()
    assert(self.scene, 'scene manager nao pode ser nil')
    -- configurar scene
    self.match = Match:new { manager = self.scene }
    self.status = Status:new(self.match)
    -- configurar efeitos
    self.effects['fog'] = FogEffect:new()
    -- configurar layers
    self.layers['floor'] = Image:new('assets/tiles/caves/floor.png')
    -- load geral
    for _, effect in ipairs(self.effects) do
        effect:load()
    end
    for _, layer in ipairs(self.layers) do
        layer:load()
    end
    self.status:load()
    self.match:load()
end

function CavesScene:draw()
end

function CavesScene:update(dt)
    self.status.match = self.match
end

return CavesScene
