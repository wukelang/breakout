local state = require('state')

local press_functions = {
    left = function()
        state.button_left = true
    end,

    right = function()
        state.button_right = true
    end,

    up = function()
        state.ball_standby = false
    end,

    -- Restart Game
    r = function()
        if state.paused then return end
        
        state.lives = state.default_lives
        state.speed = state.default_speed
        state.level = 0
        state.ball_standby = true
    end,

    m = function()
        local volume = love.audio.getVolume()
        if volume > 0 then
            love.audio.setVolume(0)
        else
            love.audio.setVolume(100)
        end
    end,

    escape = function()
        love.event.quit()
        -- if state.scene == "main" then
        --     love.event.quit()
        -- elseif state.scene == "game" then
        --     state.scene = "main"
        -- end
    end,

    space = function()
        if state.scene == "game" then

            if state.game_over or state.stage_cleared then
                return
            end

            state.paused = not state.paused
        end
    end
}

local release_functions = {
    left = function()
        state.button_left = false
    end,

    right = function()
        state.button_right = false
    end
}

return {
    press = function(pressed_key)
        state.current_key = pressed_key

        if press_functions[pressed_key] then
            press_functions[pressed_key]()
        end
    end,

    release = function(released_key)
        state.current_key = nil

        if release_functions[released_key] then
            release_functions[released_key]()
        end
    end,

    toggle_focus = function(focused)
        if not focused then
            state.paused = true
        end
    end
}