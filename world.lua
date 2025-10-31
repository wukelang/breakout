local begin_contact_counter = 0
local end_contact_counter = 0
local pre_solve_counter = 0
local post_solve_counter = 0

local begin_contact_callback = function(fixture_a, fixture_b, contact)
  print(fixture_a:getUserData(), fixture_b:getUserData(), contact, 'beginning contact')
end

local end_contact_callback = function(fixture_a, fixture_b, contact)
  print(fixture_a:getUserData(), fixture_b:getUserData(), contact, 'ending contact')
end

local pre_solve_callback = function(fixture_a, fixture_b, contact)
  print(fixture_a:getUserData(), fixture_b:getUserData(), contact, 'about to resolve a contact')
end

local post_solve_callback = function(fixture_a, fixture_b, contact)
  print(fixture_a:getUserData(), fixture_b:getUserData(), contact, 'just resolved a contact')
end


local world = love.physics.newWorld(0, 9.81 * 128)
-- local world = love.physics.newWorld(0, 5)

world:setCallbacks(
    begin_contact_callback,
    end_contact_callback,
    pre_solve_callback,
    post_solve_callback
)

return world