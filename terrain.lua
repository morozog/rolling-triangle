--! Class representing terrain
Terrain = Object:extend()

function Terrain:new()
    self.height = starting_height
    self.color = {.82, .82, .28}
end

function Terrain:draw()
    local window_height = love.graphics.getHeight()
    local window_width = love.graphics.getWidth()
    love.graphics.setColor(self.color)
    love.graphics.rectangle(
          'fill',
          0,
          window_height-self.height,
          window_width,
          self.height
    )
    love.graphics.reset()
end