return function(x_pos, y_pos)
    local entity = {}
    local frame = 0
    local time = 0
    local frame_rate = 0

    entity.draw = function(self)
        local text = "fps: " .. frame_rate
        love.graphics.print(text, x_pos, y_pos)
    end

    entity.update = function(self, dt)
        frame = frame + 1
        time = time + dt
        frame_rate = math.floor(frame / time)
    end

    return entity
end
