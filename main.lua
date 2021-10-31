local Splash = require('scenes.splashLove2d')
local SecondSplash = require('scenes.splashEquipe')
local Scene = require('core.scene')
local MenuScene = require('scenes.menu')
local BattlefieldScene = require('scenes.battlefield')
local CavesScene = require('scenes.caves')
local GameOverScene = require('scenes.gameover')

-- gerenciador de cenas

local scene = Scene:new()

function love.load()
    -- configurar game
    love.window.setIcon(love.image.newImageData('assets/icons/logo.png'))
    love.window.setTitle('Resident Grinch 1')

    -- configurar cenas
    scene:add('splash', Splash:new(scene))
    scene:add('secondsplash', SecondSplash:new(scene))
    scene:add('menu', MenuScene:new(scene))
    scene:add('battlefield', BattlefieldScene:new(scene))
    scene:add('caves', CavesScene:new(scene))
    scene:add('gameover', GameOverScene:new(scene))

    scene:change('splash') -- para testes
end

function love.draw()
    if scene:get()['draw'] then
        scene:get():draw()
    end
end

function love.update(dt)
    if scene:get()['update'] then
        scene:get():update(dt)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if scene:get()['keypressed'] then
        scene:get():keypressed(key, scancode, isrepeat)
    end
end

function love.mousepressed(x, y, button)
    if scene:get()['mousepressed'] then
        scene:get():mousepressed(x, y, button)
    end
end
