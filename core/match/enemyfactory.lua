--
-- fabrica de enimigos, gera varios tipos de enimigos aqui
--
local Enemy = require('core.match.enemy')
local Image = require('core.image')
EnemyFactory = {}

function EnemyFactory.spider(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Spider'
    enemy.x = x
    enemy.y = y
    return enemy
end

function EnemyFactory.mouse(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Mouse'
    enemy.x = x
    enemy.y = y
    enemy.sprite = Image:new('assets/sprites/mouse_walk.png') -- mouse_walk
    return enemy
end

function EnemyFactory.bat(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Bat'
    enemy.x = x
    enemy.y = y
    return enemy
end

function EnemyFactory.pumpkin(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Pumpkin'
    enemy.x = x
    enemy.y = y
    return enemy
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