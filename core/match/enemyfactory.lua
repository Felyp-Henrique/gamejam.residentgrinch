--
-- fabrica de enimigos, gera varios tipos de enimigos aqui
--
local Enemy = require('core.match.enemy')

EnemyFactory = {}

function EnemyFactory.spider(x, y)
    return Enemy:new {
        nick = 'Spider',
        x = x,
        y = y,
    }
end

function EnemyFactory.mouse(x, y)
    return Enemy:new {
        nick = 'Mouse',
        x = x,
        y = y,
    }
end

function EnemyFactory.bat(x, y)
    return Enemy:new {
        nick = 'Bat',
        x = x,
        y = y,
    }
end

function EnemyFactory.pumpkin(x, y)
    return Enemy:new {
        nick = 'Pumpkin',
        x = x,
        y = y,
    }
end

function EnemyFactory.random(x, y)
    math.randomseed(os.time())
    local index = math.random(0, 3)
    if index == 0 then
        return EnemyFactory.spider(x, y)
    elseif index == 1 then
        return EnemyFactory.mouse(x, y)
    elseif index == 2 then
        return EnemyFactory.bat(x, y)
    elseif index == 3 then
        return EnemyFactory.pumpkin(x, y)
    end
end

return EnemyFactory