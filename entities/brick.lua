local world = require('world')
local state = require('state')

local health_color_map = {
    {0, 1, 0},
    {1, 1, 0},
    {1, 0, 0}
}

return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(60, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.type = 'brick'
    entity.health = 2

    entity.draw = function(self)
        love.graphics.setColor(health_color_map[self.health] or state.default_color)
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.setColor(state.default_color)
    end

    entity.end_contact = function(self)
        self.health = self.health - 1
    end

    return entity

end
