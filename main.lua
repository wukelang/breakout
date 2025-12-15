local world = require('world')
local entities = require('entities')
local input = require('input')
local state = require('state')
local sounds = require('sounds')

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.load = function()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 0.1)
end

love.update = function(dt)
    if state.game_over or state.paused or state.stage_cleared then
        return
    end

    local have_bricks = false
    local index = 1
    while index <= #entities do
        local entity = entities[index]

        if entity.type == 'brick' then have_bricks = true end

        if entity.update then entity:update(dt) end

        if entity.health and entity.health < 1 then
            table.remove(entities, index)
            if entity.on_destroy then entity.on_destroy() end
            entity.fixture:destroy()
        else
            index = index + 1
        end
    end

    state.stage_cleared = not have_bricks
    world:update(dt)
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
