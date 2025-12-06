local world = require('world')

return function(x_pos, y_pos)
    local entity_min_speed = 500
    local entity_max_speed = 500

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
    entity.body:setMass(32)
    entity.body:setLinearVelocity(300, -300)
    entity.shape = love.physics.newCircleShape(200, 200, 10)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setRestitution(1)
    entity.fixture:setFriction(0)
    entity.fixture:setUserData(entity)

    entity.type = "ball"

    entity.draw = function(self)
        local self_x, self_y = self.body:getWorldCenter()
        love.graphics.circle('fill', self_x, self_y, self.shape:getRadius())
    end

    entity.update = function(self, dt)
        local vel_x, vel_y = self.body:getLinearVelocity()
        local speed = math.abs(vel_x) + math.abs(vel_y)

        local vel_x_is_critical = math.abs(vel_x) > entity_max_speed
        local vel_y_is_critical = math.abs(vel_y) > entity_max_speed
        local vel_x_too_slow = math.abs(vel_x) < entity_min_speed
        local vel_y_too_slow = math.abs(vel_y) < entity_min_speed

        if vel_x_is_critical or vel_y_is_critical then
            self.body:setLinearVelocity(vel_x * .50, vel_y * .50)
        end
        if vel_x_too_slow then
            self.body:setLinearVelocity(vel_x * 1.01, vel_y)
        end
        if vel_y_too_slow then
            self.body:setLinearVelocity(vel_x, vel_y * 1.01)
        end

        -- print(speed)
        if speed > entity_max_speed then
            self.body:setLinearDamping(0.4)
        else
            self.body:setLinearDamping(0)
        end
    end


    return entity
end