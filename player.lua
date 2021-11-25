--! Class representing player 1 
Player = Object:extend()

function Player:new()
    -- getting the image with the constant center
    self.image = love.graphics.newImage("gfx/triangle_centered.png")
    self.image_angle = starting_angle   
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
    self.c_angle = starting_angle
    self.d = 2 * math.pi * self.size/6
    self.degrees = 0
    self.radians = 0
    self.n = 0

    -- active vertice starts at none
    self.active_vertex = "none"

    -- setting up logger
    self.logger = ScreenLogger()
end

function Player:triangle_update(inc)
    -- increasing/decreasing the rotataion degree
    self.c_angle = self.c_angle + inc
end 

function Player:update(dt)
    local is_down_left, data, duration = Input.down('left')
    local is_down_right, data, duration = Input.down('right')
    local rs = Input.duration('right')
    local ls = Input.duration('left')
    
    if is_down_left then
        assert(data == nil)
        self:triangle_update(-1* self.speed * dt)
    elseif is_down_right then
        assert(data == nil)
        self:triangle_update( self.speed * dt)
    else
        self:stabilize(rs,ls)
    end
end

function Player:draw(terrain_height)
    self:calc_vertices()
    self:get_active_vertex()
    cur_hi = love.graphics.getHeight()-terrain_height
    love.graphics.draw(self.image, self.center_x, cur_hi-self.center_y, self.image_angle, 
        1,1, self.image_size/2,self.image_size/2)
    love.graphics.polygon("line", self.c1x, cur_hi-self.c1y, 
        self.c2x,cur_hi-self.c2y,
        self.c3x,cur_hi-self.c3y)

    -- Log player details
    self.logger:log(
        string.format("Angle: %s",math.deg(self.image_angle)),
        string.format("x1: %s x2: %s x3: %s Center x: %s", self.c1x, self.c2x, self.c3x, self.center_x),
        string.format("y1: %s y2: %s y3: %s Center y: %s", self.c1y, self.c2y, self.c3y, self.center_y),
        self.active_vertex
    )
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

function Player:get_active_vertex()
    cur_angle = math.mod(self.c_angle, 360)
    if((cur_angle >blue_angle-color_angle_interval) and (cur_angle <blue_angle+color_angle_interval)) then
        self.active_vertex  = "blue"
    elseif ((cur_angle >green_angle-color_angle_interval) and (cur_angle <green_angle+color_angle_interval)) then
        self.active_vertex  = "green"
    elseif ((cur_angle >red_angle-color_angle_interval) and (cur_angle <red_angle+color_angle_interval)) then
        self.active_vertex  = "red"
    else
        self.active_vertex  = "none"
    end 
end

function Player:stabilize(rsec,lsec)
    local rs, ls
    if(rsec==nil)then rs=stab_int + 1 else rs=rsec end
    if(lsec==nil)then ls=stab_int + 1 else ls=lsec end
    if((rs>stab_int)and(ls>stab_int))then
        -- TODO: write the logic for stabilizing the triangle if it is on one of its vertices
        print("need to stabilize! R:"..rs.." L: "..ls) 
    end
end