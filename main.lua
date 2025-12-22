local input = require('input')
local state = require('state')
local game_scene = require('scenes/game-scene')
local main_menu_scene = require('scenes/main-menu-scene')


love.draw = function()
    if state.scene == "main" then
        main_menu_scene:draw()

    elseif state.scene == "game" then
        game_scene:draw()
    end
end

love.load = function()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 0.1)
end

love.update = function(dt)
    -- state.last_scene = state.scene

    if state.scene == "game" then
        -- Reset game if entering from different state

        game_scene:update(dt)
    end
end

love.focus = function(focused)
    input.toggle_focus(focused)
end

love.keypressed = function(key)
    input.press(key)
end

love.keyreleased = function(key)
    input.release(key)
end
