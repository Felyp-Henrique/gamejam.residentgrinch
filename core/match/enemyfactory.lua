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

    enemy.sprite = Image:new() 
    enemy.spdeath = Image:new()
    enemy.sprite.path = ('assets/sprites/spider_spritesheet.png') -- mouse_walk
    enemy.spritedeath.path = ('assets/sprites/spider_death.png')
    enemy.audio_spawn = love.audio.newSource("assets/audios/spider_spawn.ogg", "static")
    enemy.audio_death = love.audio.newSource("assets/audios/spider_death.ogg", "static")    
    return enemy
end

function EnemyFactory.mouse(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Mouse'
    enemy.x = x
    enemy.y = y
    enemy.sprite = Image:new() 
    enemy.spdeath = Image:new()
    enemy.sprite.path = 'assets/sprites/mouse_spritesheet.png'
    enemy.spdeath.path = 'assets/sprites/mouse_death.png'
    enemy.audio_spawn = love.audio.newSource("assets/audios/mouse_spawn" .. pickOne(2) .. ".ogg", "static")
    enemy.audio_death = love.audio.newSource("assets/audios/mouse_death.ogg", "static")
    return enemy
end

function EnemyFactory.bat(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Bat'
    enemy.x = x
    enemy.y = y

    enemy.sprite = Image:new() 
    enemy.spdeath = Image:new()
    enemy.sprite.path = ('assets/sprites/bat_spritesheet.png') -- mouse_walk
    enemy.spritedeath.path = ('assets/sprites/bat_death.png')
    enemy.audio_spawn = love.audio.newSource("assets/audios/bat_spawn.ogg", "static")
    enemy.audio_death = love.audio.newSource("assets/audios/bat_death.ogg", "static")    
    return enemy
end

function EnemyFactory.pumpkin(x, y)
    local enemy = Enemy:new()
    enemy.nick = 'Pumpkin'
    enemy.x = x
    enemy.y = y

    enemy.sprite = Image:new() 
    enemy.spdeath = Image:new()
    enemy.sprite.path = ('assets/sprites/abobora_spritesheet.png') -- mouse_walk
    enemy.spritedeath.path = ('assets/sprites/abobora_death.png')
    enemy.audio_spawn = love.audio.newSource("assets/audios/abobora_spawn.ogg", "static")
    enemy.audio_death = love.audio.newSource("assets/audios/abobora_death.ogg", "static")    
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

function pickOne(max)
    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()
    return tostring(math.floor(math.random(1.5,0.5+max)))
end

return EnemyFactory