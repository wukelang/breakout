local world = require('world')
local state = require('state')

return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(6000, 10)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.end_contact = function()
        state.lives = state.lives - 1

        if state.lives > 0 then
            state.ball_standby = true
        end
    end

    return entity
end