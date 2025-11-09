local world = require('world')
local entities = require('entities')
local input = require('input')

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.update = function(dt)
    if not input.paused then
        for _, entity in ipairs(entities) do
            if entity.update then entity:update(dt) end
        end

        world:update(dt)
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