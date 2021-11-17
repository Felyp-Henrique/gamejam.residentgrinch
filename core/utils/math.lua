--- Utils matematicos
---
--- @class MathUtil
local MathUtil = {}

--- Calcula a distancia entre dois objetos
---
--- @param x1 number posicao no eixo x do objeto 1
--- @param y1 number posicao no eixo y do objeto 1
--- @param x2 number posicao no eixo x do objeto 2
--- @param y2 number posicao no eixo y do objeto 2
--- @return number
function MathUtil.distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end


--- Gera um numero randomico
---
--- @param min number
--- @param max number
--- @return number
function MathUtil.random(min, max)
    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()
    return math.random(min, max)
end

return MathUtil