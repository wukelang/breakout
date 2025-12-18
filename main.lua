local input = require('input')
local state = require('state')
local generate_bricks = require("generate-bricks")
local entity_manager = require('entity-manager')
local game_scene = require("game-scene")


love.draw = function()
    entity_manager:draw()
end

love.load = function()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 0.1)
end

love.update = function(dt)
    game_scene:update(dt, entity_manager)

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
