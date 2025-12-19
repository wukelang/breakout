local world = require('world')
local state = require('state')
local sounds = require('sounds')
local textures = require('textures')

-- TODO: refactor into smaller components

local function new_button(text, fn)
    return {
        text = text,
        fn = fn,

        now = false,
        last = false
    }
end


return function(x_pos, y_pos)
    local buttons = {}

    table.insert(buttons, new_button(
        "START", function() state.scene = "game" end
    ))

    -- table.insert(buttons, new_button(
    --     "TEST"
    -- ))

    table.insert(buttons, new_button(
        "QUIT", function() love.event.quit(0) end
    ))


    local entity = {}

    entity.draw = function(self)
        local window_width, window_height = love.window.getMode()
        local button_width = window_width / 3
        local button_height = 50
        local y_margin = 16
        local y_cursor = 0

        local title_text = "BREAKOUT++"
        local title_width = textures.big_font:getWidth(title_text)
        local title_height = textures.big_font:getHeight(title_text)

        love.graphics.print("Lang 2025", textures.font, 650, 560)

        love.graphics.print("BREAKOUT++", textures.big_font,
            (window_width / 2) - (title_width / 2),
            (window_height / 2) - title_height - 100
            )

        for i, button in ipairs(buttons) do
            button.last = button.now
            local bx = (window_width / 2) - (button_width / 2)
            local by = (window_height / 2) + (y_cursor)
            local text_width = textures.font:getWidth(button.text)
            local text_height = textures.font:getHeight(button.text)
            local color = state.default_color
            local button_fill = "line"

            local mx, my = love.mouse.getPosition()
            local button_hover = (mx > bx and mx < bx + button_width) and
                             (my > by and my < by + button_height)

            if button_hover then
                button_fill = "fill"
                love.graphics.setColor({1.0, 1, 1, 0.5})
            end
            
            button.now = love.mouse.isDown(1)  -- Left Click
            if button.now and button.last == false and button_hover then
                button.fn()
            end

            love.graphics.rectangle(
                button_fill,
                bx,
                by,
                button_width,
                button_height
            )

            love.graphics.setColor(state.default_color)
            love.graphics.print(
                button.text,
                textures.font,
                (window_width / 2) - (text_width / 2),
                by + (text_height / 2)
            )

            y_cursor = y_cursor + button_height + y_margin

        end



    end

    return entity

end
