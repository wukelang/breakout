local world = require('world')
local state = require('state')
local textures = require('textures')

local health_color_map = {
    { outline = {0, 1, 0, 1}, fill = {0, 1, 0, 0.3} },
    { outline = {1, 1, 0, 1}, fill = {1, 1, 0, 0.3} },
    { outline = {1, 0, 0, 1}, fill = {1, 0, 0, 0.3} }
}

return function(x_pos, y_pos, health)
    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'static')
    entity.shape = love.physics.newRectangleShape(60, 20)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)
    entity.image = textures.bomb

    entity.type = 'brick'
    entity.health = health or 1


    entity.draw = function(self)
        local angle = self.body:getAngle()

        if self.health > 0 then
            love.graphics.setColor(health_color_map[self.health].outline or state.default_color)
            love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
            love.graphics.draw(self.image, x_pos, y_pos, angle, 1, 1, self.image:getWidth()/2, self.image:getHeight()/2)

            love.graphics.setColor(health_color_map[self.health].fill or state.default_color)
            love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))


        end
        love.graphics.setColor(state.default_color)
    end

    entity.end_contact = function(self)
        self.health = self.health - 1
    end

    return entity

end
