local begin_contact_counter = 0
local end_contact_counter = 0
local pre_solve_counter = 0
local post_solve_counter = 0

local begin_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.begin_contact then entity_a:begin_contact(entity_a, entity_b, contact) end
    if entity_b.begin_contact then entity_b:begin_contact(entity_b, entity_a, contact) end
end

local end_contact_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.end_contact then entity_a:end_contact(entity_a, entity_b, contact) end
    if entity_b.end_contact then entity_b:end_contact(entity_b, entity_a, contact) end
end

local pre_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.pre_solve_contact then entity_a:pre_solve_contact(entity_a, entity_b, contact) end
    if entity_b.pre_solve_contact then entity_b:pre_solve_contact(entity_b, entity_a, contact) end
end

local post_solve_callback = function(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.post_solve_contact then entity_a:post_solve_contact(entity_a, entity_b, contact) end
    if entity_b.post_solve_contact then entity_b:post_solve_contact(entity_b, entity_a, contact) end

end

local world = love.physics.newWorld(0, 0)

world:setCallbacks(
    begin_contact_callback,
    end_contact_callback,
    pre_solve_callback,
    post_solve_callback
)

return world
