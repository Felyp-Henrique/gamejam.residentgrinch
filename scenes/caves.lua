local Match = require('core.match.match')
local Status = require('core.ui.status')
local FogEffect = require('core.effects.fog')
local Image = require('core.image')

CavesScene = {}

function CavesScene:new(manager)
    assert(manager, 'scene manager nao pode ser nil')
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.effects = {}
    self.status = nil
    self.tiles = {}
    self.match = nil
    self.scene = manager
    return obj
end

-- metodos love

function CavesScene:load()
    -- configurar scene
    self.match = Match:new { manager = self.scene }
    self.status = Status:new(self.match)
    -- configurar efeitos
    self.effects['fog'] = FogEffect:new()
    -- configurar tiles
    self.tiles['floor'] = Image:new('assets/tiles/caves/floor.png')
    -- load geral
    for _, effect in ipairs(self.effects) do
        effect:load()
    end
    for _, layer in ipairs(self.tiles) do
        layer:load()
    end
    self.match:load()
end

function CavesScene:draw()
    -- self.tiles.floor:draw()
    self.match:draw()
    -- self.effects.fog:draw()
    self.status:draw()
end

function CavesScene:update(dt)
    self.status.match = self.match
end

return CavesScene
