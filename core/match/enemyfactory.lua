--
-- fabrica de enimigos, gera varios tipos de enimigos aqui
--
local Enemy = require('core.match.enemy')
local Image = require('core.image')
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
        sprite = Image:new('assets/sprites/mouse_walk.png'),
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
    -- acho que aqui merece também um math.floor
    local index = math.floor(math.random(0, 3.9))
    --if index == 0 then
    --    return EnemyFactory.spider(x, y)
    --elseif index == 1 then
        return EnemyFactory.mouse(x, y)
    --elseif index == 2 then
    --    return EnemyFactory.bat(x, y)
    --elseif index == 3 then
    --    return EnemyFactory.pumpkin(x, y)
    --end
end

return EnemyFactory