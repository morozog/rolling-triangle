--! Main Love execution flow
function love.load()
    Object = require "lib/classic"
    Input = require "lib/input"
    require "player"
    require "terrain"
    require "logger"

    player = Player()
    terrain = Terrain()
    Input.bind_callbacks()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw(terrain:getHeight())
    terrain:draw()
end
