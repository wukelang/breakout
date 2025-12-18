
return {
    ball_standby = true,
    paddle_center_x = 400,
    paddle_center_y = 300,
    default_lives = 1,
    lives = 1,
    level = 0,
    default_speed = 500,
    speed = 500,
    button_left = false,
    button_right = false,
    current_key = nil,
    game_over = false,
    default_color = { 1.0, 1.0, 1.0, 1.0 },
    palette = {
        {1.0, 0.0, 0.0, 1.0},  -- red
        {0.0, 1.0, 0.0, 1.0},  -- green
        {0.4, 0.4, 1.0, 1.0},  -- blue
        {0.9, 1.0, 0.2, 1.0},  -- yellow
        {1.0, 1.0, 1.0, 1.0}   -- white
    },
    paused = false,
    stage_cleared = false,
    have_bricks = false
}
