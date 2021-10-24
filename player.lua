--! Class representing player 1 
Player = Object:extend()

function Player:new()
    -- getting the image with the constant center
    self.image = love.graphics.newImage("gfx/triangle_centered.png")
    self.image_angle = 0
    self.image_size = self.image:getHeight()

    -- setting initial movement speed
    self.speed = starting_speed

    -- setting initial triangle parameters
    self.size = starting_size

    --triangle vertices initial parameters
    self.c1x = 0
    self.c1y = self.size
    self.c2x = 0
    self.c2y = 0
    self.c_angle = 0
    self.d = 2 * math.pi * self.size/6
    self.degrees = 0
    self.radians = 0
    self.n = 0
end

function Player:triangle_update(inc)
    -- increasing/decreasing the rotataion degree
    self.c_angle = self.c_angle + inc
end 

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self:triangle_update(-1* self.speed * dt)
    elseif love.keyboard.isDown("right") then
        self:triangle_update( self.speed * dt)
    end
end

function Player:draw(terrain_height)
    self:calc_vertices()
    cur_hi = love.graphics.getHeight()-terrain_height
    love.graphics.draw(self.image, self.center_x, cur_hi-self.center_y, self.image_angle, 
        1,1, self.image_size/2,self.image_size/2)
    love.graphics.polygon("line", self.c1x, cur_hi-self.c1y, 
        self.c2x,cur_hi-self.c2y,
        self.c3x,cur_hi-self.c3y)

    -- Debug information 
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print(string.format("Angle: %s",math.deg(self.image_angle)), 10, 10)
    love.graphics.print(string.format("x1: %s x2: %s x3: %s Center x: %s",
        self.c1x, self.c2x, self.c3x, self.center_x), 10, 30)
    love.graphics.print(string.format("y1: %s y2: %s y3: %s Center y: %s",
        self.c1y, self.c2y, self.c3y, self.center_y), 10, 50)
end

function Player:calc_vertices()
     -- determining the location of the three vertices of the triangle by the rotation degree
    self.degrees = math.mod(self.c_angle, 120)
    self.n = math.floor(self.c_angle/120)
    self.radians = math.rad(self.degrees)
    self.image_angle = math.rad(math.mod(self.c_angle, 360))
    if (self.degrees >=0) and (self.degrees <=60) then
        self.c1x =self.n * self.d + self.size*self.radians 
        self.c1y = self.size
        self.c2x = self.n * self.d + self.size * (self.radians - math.sin(self.radians))
        self.c2y = self.size * (1 - math.cos(self.radians))
    else
        self.c1x =self.n * self.d + self.d + self.size * math.sin(math.rad(self.degrees - 60))
        self.c1y = self.size * math.cos(math.rad(self.degrees - 60))
        self.c2x = self.n * self.d + self.d + self.size * math.cos(math.rad(210 - self.degrees))
        self.c2y = self.size * math.sin(math.rad(210 - self.degrees))
    end
    self.c3x=(self.c2x-self.c1x)*math.cos(math.rad(60))-(self.c2y-self.c1y)*math.sin(math.rad(60))+self.c1x
    self.c3y=(self.c2x-self.c1x)*math.sin(math.rad(60))+(self.c2y-self.c1y)*math.cos(math.rad(60))+self.c1y
    self.center_x = (self.c1x+self.c2x+self.c3x)/3
    self.center_y = (self.c1y+self.c2y+self.c3y)/3
end