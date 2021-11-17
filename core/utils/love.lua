--- Utils baseado em recursos do Love2D
---
--- @class LoveUtils
local LoveUtils = {}

--- Obtem a escala global do jogo(width / 600)
---
--- @return number
function LoveUtils.getScale()
    return love.graphics.getHeight() / 600
end

--- Obtem o centro do eixo x
---
--- @return number
function LoveUtils.getCenterX()
    return love.graphics.getWidth() / 2
end

--- Obtem o centro do eixo y
---
--- @return number
function LoveUtils.getCenterY()
    return love.graphics.getHeight() / 2
end

--- Obtem a largura da tela
---
--- @return number
function LoveUtils.getWidth()
    return love.graphics.getWidth()
end

--- Obtem a altura da tela
---
--- @return number
function LoveUtils.getHeight()
    return love.graphics.getHeight()
end

--- Obtem font padrao
---
--- @return love.Font
function LoveUtils.getFont()
    return love.graphics.newFont(30)
end

return LoveUtils