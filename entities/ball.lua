local world = require('world')
local state = require('state')
local sounds = require('sounds')


return function(x_pos, y_pos)
    local entity_min_speed = 500
    local entity_max_speed = 500

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
    entity.body:setMass(32)
    
    entity.body:setLinearVelocity(0, 0)
    entity.shape = love.physics.newCircleShape(10)
    entity.fixture = love.physics.newFixture(entity.body, entity.shape)
    entity.fixture:setRestitution(1)
    entity.fixture:setFriction(0)
    entity.fixture:setUserData(entity)

    entity.type = "ball"
    entity.last_state = nil

    entity.draw = function(self)
        local self_x, self_y = self.body:getWorldCenter()
        love.graphics.circle('fill', self_x, self_y, self.shape:getRadius())
    end

    entity.launch = function(self)
        if state.button_left and state.button_right then
            entity.body:setLinearVelocity(0, -300)
        elseif state.button_left then
            entity.body:setLinearVelocity(-300, -300)
        elseif state.button_right then
            entity.body:setLinearVelocity(300, -300)
        else
            entity.body:setLinearVelocity(0, -300)
        end

        entity.last_state = "normal"
    end

    entity.update = function(self, dt)
        if state.ball_standby == true then
            self.body:setLinearVelocity(0, 0)
            local posx, posy = self.body:getPosition()
            self.body:setPosition(state.paddle_center_x, math.floor(state.paddle_center_y - 20))
            entity.last_state = "standby"

        else
            local vel_x, vel_y = self.body:getLinearVelocity()
            local speed = math.abs(vel_x) + math.abs(vel_y)
            if entity.last_state == "standby" and state.ball_standby == false then
                self.launch()
            end

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

            if speed > entity_max_speed then
                self.body:setLinearDamping(0.4)
            else
                self.body:setLinearDamping(0)
            end

        end

    end

    entity.pre_solve_contact = function(self, entity_a, entity_b, contact)
        if entity_b.type and entity_b.type == "brick" then
            sounds.brick_blip:play()
        elseif entity_b.type and entity_b.type == "paddle" then
            sounds.blip:play()
        end
    end

    return entity
end