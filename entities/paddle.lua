local world = require('world')
local input = require('input')

return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(150, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.draw = function(self)
        love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.update = function(self, dt)
        if input.left and input.right then
            return
        end

        local self_x, self_y = self.body:getPosition()
        local movespeed = (500 * dt)

        if input.left then
            local new_x = math.max(self_x - movespeed, 75)
            self.body:setPosition(new_x, self_y)
        elseif input.right then
            local new_x = math.min(self_x + movespeed, 725)
            self.body:setPosition(new_x, self_y)
        end
    end

    return entity
end