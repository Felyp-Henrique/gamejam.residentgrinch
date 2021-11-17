local AssetObject = require('core.assets.assetobject')

--- Representa um ativo estatico de imagem
---
--- @class ImageAsset
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
--- @field path string caminho da imagem
---
--- @see AssetObject
local ImageAsset = AssetObject:new()

--- Instancia um ativo de imagem
---
--- @param obj table
--- @return ImageAsset
function ImageAsset:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function ImageAsset:load()
    assert(self.path, 'ImageAsset:path não pode ser uma string vazia ou nula')
    self.__image = love.graphics.newImage(self.path)
    self.width = self.__image:getWidth()
    self.height = self.__image:getHeight()
    -- calcular com base na largura do spritesheet
    self.ox = (self.width / (self.width / self.height)) / 2
    self.oy = self.height / 2
end

function ImageAsset:draw()
    love.graphics.draw(
        self.__image,
        self.x,
        self.y,
        self.r,
        self.sx,
        self.sy,
        self.ox,
        self.oy
    )
end

return ImageAsset