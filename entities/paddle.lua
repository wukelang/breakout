local world = require('world')
local state = require('state')

return function(x_pos, y_pos)
    local window_width = love.window.getMode()
    local entity_width = 120
    local entity_height = 5
    local entity_speed = 800
    local paddle_radius = 60
    local left_boundary = (entity_width / 2) + 2
    local right_boundary = window_width - (entity_width / 2) - 2
    local max_bounce_angle = 70

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'kinematic')
    entity.shape = love.physics.newRectangleShape(entity_width, entity_height)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setUserData(entity)
    entity.type = "paddle"

    entity.draw = function(self)
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    end

    entity.update = function(self, dt)
        if state.button_left and state.button_right then
            self.body:setLinearVelocity(0, 0)
        end

        local self_x = self.body:getX()

        if state.button_left and self_x > left_boundary then
            self.body:setLinearVelocity(-entity_speed, 0)
        elseif state.button_right and self_x < right_boundary then
            self.body:setLinearVelocity(entity_speed, 0)
        else
            self.body:setLinearVelocity(0, 0)
        end
    end

    entity.pre_solve_contact = function(self, entity_a, entity_b, contact)
        if entity_b.type and entity_b.type == "ball" then
            local ball_entity = entity_b
            local contact_x, contact_y = contact:getPositions()
            local paddle_center_x = entity_a.body:getPosition()

            -- Get contact position diff from paddle center, normalize into value between -1 - 1
            local relative_x_intersection = paddle_center_x - contact_x
            local normalized_x_intersection = relative_x_intersection / (entity_width / 2)

            -- Trigonometry to calculate velocities using bounce angle
            local bounce_angle = 90 + (max_bounce_angle * normalized_x_intersection)
            local ball_vx = math.cos(math.rad(bounce_angle))
            local ball_vy = math.sin(math.rad(bounce_angle))
            ball_entity.body:setLinearVelocity(500 * ball_vx, 500 * ball_vy)
        end

    end

    return entity
end
