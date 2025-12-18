local world = require('world')
local state = require('state')
local sounds = require('sounds')
local generate_bricks = require("generate-bricks")
local entity_manager = require('entity-manager')


local game = {}

game.reset_entities = function(self, entity_manager)
    entity_manager:clear()

    -- UI, Core Gameplay
    local entities = generate_bricks:generate_game_entities()
    for _, entity in ipairs(entities) do
        entity_manager:add(entity)
    end

    -- Bricks
    local bricks = generate_bricks:generate_bricks()
    for _, brick in ipairs(bricks) do
        entity_manager:add(brick)
    end

    sounds.game_start:play()
end

game.draw = function(self)
    entity_manager:draw()
end

-- game.update = function(self, dt, entity_manager)
game.update = function(self, dt)
    state.game_over = false
    if state.lives <= 0 then
        state.game_over = true
    end

    if state.game_over or state.paused then 
        return
    end

    -- Reset Game
    if state.level == 0 then
        game.reset_entities(self, entity_manager)
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

        -- local bricks = generate_bricks:generate_bricks(entities)
        local bricks = generate_bricks:generate_bricks()
        for _, brick in ipairs(bricks) do
            entity_manager:add(brick)
        end

        -- state.stage_cleared = false
        -- print("stage clear", state.level)
        state.level = state.level + 1
        state.speed = state.speed + 20
        sounds.level_clear:play()
    end

    entity_manager:update(dt)

    world:update(dt)
end

return game

