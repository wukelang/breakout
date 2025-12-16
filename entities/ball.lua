local world = require('world')
local state = require('state')
local sounds = require('sounds')


return function(x_pos, y_pos)
    local entity_min_speed = 500
    local entity_max_speed = 500

    local entity = {}
    entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
    entity.body:setMass(32)
    entity.body:setLinearDamping(0)
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

        local vx, vy = self.body:getLinearVelocity()
        vx = math.floor(vx)
        vy = math.floor(vy)
        local text = "ball: " .. vx .. " " .. vy
        love.graphics.print(text, 0, 580)
    end

    entity.launch = function(self)
        if state.button_left and state.button_right then
            entity.body:setLinearVelocity(0, -500)
        elseif state.button_left then
            entity.body:setLinearVelocity(-300, -300)
        elseif state.button_right then
            entity.body:setLinearVelocity(300, -300)
        else
            entity.body:setLinearVelocity(0, -500)
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

            -- Prevent fast ball when contacting with moving paddle side 
            if vel_x_is_critical then
                if vel_x > 0 then
                    self.body:setLinearVelocity(entity_max_speed, vel_y)
                else
                    self.body:setLinearVelocity(-entity_max_speed, vel_y)
                end
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