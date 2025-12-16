local world = require('world')
local entities = require('entities')
local input = require('input')
local state = require('state')
local sounds = require('sounds')
local generate_bricks = require("generate-bricks")

love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.load = function()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 0.1)
end

love.update = function(dt)
    local have_bricks = false
    local index = 1

    state.game_over = false
    if state.lives <= 0 then
        state.game_over = true
    end

    if state.game_over or state.paused then
        return
    end

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

    -- Generate new bricks if stage cleared.
    if have_bricks ~= true then
        local bricks = generate_bricks:generate_bricks(entites)
        for i=1, #bricks do
            entities[#entities+1] = bricks[i]
        end
        state.stage_cleared = false
        state.ball_standby = true
        state.level = state.level + 1
        state.speed = state.speed + 20
        -- have_bricks = true
    end

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
