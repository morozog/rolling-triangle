--! Main Love execution flow
function love.load()
    Object = require "lib/classic"
    require "player"
    require "terrain"

    player = Player()
    terrain = Terrain()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    terrain:draw()
end
