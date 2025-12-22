local world = require('world')
local state = require('state')

return function(x_pos, y_pos)
    local window_width = love.window.getMode()
    local entity_width = 120
    local entity_height = 5
    -- local entity_height = 40
    local paddle_speed = state.default_speed
    local bounce_speed = state.default_speed
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
        bounce_speed = state.speed
        paddle_speed = state.speed
        -- print("paddle bounce speed:", bounce_speed)
        
        if state.button_left and state.button_right then
            self.body:setLinearVelocity(0, 0)
        end

        local self_x = self.body:getX()
        local self_y = self.body:getY()
        -- state.paddle_center_x, state.paddle_center_y = self.body:getPosition()
        state.paddle_center_x, state.paddle_center_y = self_x, self_y

        if state.button_left and self_x > left_boundary then
            self.body:setLinearVelocity(-paddle_speed, 0)
        elseif state.button_right and self_x < right_boundary then
            self.body:setLinearVelocity(paddle_speed, 0)
        else
            self.body:setLinearVelocity(0, 0)
        end
    end

    entity.pre_solve_contact = function(self, entity_a, entity_b, contact)
        if entity_b.type and entity_b.type == "ball" then
            local ball_entity = entity_b
            local contact_x, contact_y = contact:getPositions()
            local paddle_center_x, paddle_center_y = entity_a.body:getPosition()
            -- print("Contact:", contact_x, contact_y)

            -- Get contact position diff from paddle center, normalize into value between -1 - 1
            local relative_x_intersection = paddle_center_x - contact_x
            local normalized_x_intersection = relative_x_intersection / (entity_width / 2)
            -- print("Intersection: ", relative_x_intersection, normalized_x_intersection)

            -- Trigonometry to calculate velocities using bounce angle
            local bounce_angle = 90 + (max_bounce_angle * normalized_x_intersection)
            local ball_vx = math.cos(math.rad(bounce_angle))
            local ball_vy = math.sin(math.rad(bounce_angle))
            -- print("Ball velocity: ", ball_vx, ball_vy)

            -- TODO: rewrite edge case handling, for some reason ball goes downwards despite correct ball_vy
            if math.abs(normalized_x_intersection) > 1 then
                -- print("paddle side hit")
                ball_entity.body:setLinearVelocity(bounce_speed * ball_vx, bounce_speed * -0.34)
                return
            end

            ball_entity.body:setLinearVelocity(bounce_speed * ball_vx, bounce_speed * ball_vy)
        end

    end

    return entity
end
