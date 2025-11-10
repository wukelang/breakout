local world = require('world')

local health_color_map = {
    {0, 0, 0},
    {0, 1, 0},
    {1, 1, 0},
    {1, 0, 0}
}

return function(x_pos, y_pos)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(50, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)

    entity.health = 3

    entity.draw = function(self)
        love.graphics.setColor(health_color_map[self.health + 1])
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.setColor({1, 1, 1})
    end

    entity.end_contact = function(self)
        self.health = self.health - 1
    end

    return entity

end
