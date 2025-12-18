local world = require('world')
local input = require('input')
local state = require('state')
local sounds = require('sounds')
local generate_bricks = require("generate-bricks")
local entity_manager = require('entity-manager')


love.draw = function()
    entity_manager:draw()
end

love.load = function()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1, 0.1)
end

love.update = function(dt)
    state.game_over = false
    if state.lives <= 0 then
        state.game_over = true
    end
    
    if state.game_over or state.paused then
        return
    end
    
    -- TODO: refactor into game state entity?
    -- Reset: destroy and regenerate game entities.
    if state.level == 0 then
        entity_manager:clear()
        local entities = generate_bricks:generate_game_entities()
        entity_manager:add_list(entities)
        local bricks = generate_bricks:generate_bricks()
        entity_manager:add_list(bricks)
        state.level = 1
    end
    
    state.have_bricks = false
    for _, entity in ipairs(entity_manager.entities) do
        if entity.type == 'brick' then 
            state.have_bricks = true 
        end
    end

    -- Generate new bricks if no bricks left.
    if state.have_bricks ~= true then
        state.ball_standby = true

        local bricks = generate_bricks:generate_bricks()
        entity_manager:add_list(bricks)
        -- state.stage_cleared = false
        state.level = state.level + 1
        state.speed = state.speed + 20
        sounds.level_clear:play()
    end

    -- Update each entity.
    local index = 1
    while index <= #entity_manager.entities do
        local entity = entity_manager.entities[index]

        if entity.update then entity:update(dt) end

        if entity.health and entity.health < 1 then
            table.remove(entity_manager.entities, index)
            if entity.on_destroy then entity.on_destroy() end
            entity.fixture:destroy()
        else
            index = index + 1
        end
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
