Room = {}

function Room:new(bg, n)
    local this = {}
    setmetatable(Room, this)

    this.sky = lovr.graphics.newTexture(bg)
    this.name = n

    this.connections = {}
    this.directions = {}

    -- Private member variables
    this._angle = lovr.math.newVec2()
    this._angle:set(0,-10)

    this.addRooms = function(r, d)
        this.connections = r
        this.directions = d
    end

    this.draw = function()
        lovr.graphics.skybox(this.sky)
        
        for i = 1, #this.connections do 
            -- Circle rotation
            local ang = this.directions[i] 

            this._angle.x = math.cos(ang)*10
            this._angle.y = math.sin(ang)*10

            lovr.graphics.print(
                this.connections[i].name,       -- Text
                this._angle.x,2,this._angle.y,  -- Position
                1,                              -- Scale
                -(ang+(math.pi/2)),             -- Angle (radians)
                0,1,0)                          -- Axis of rotation
        end
    end

    return this
end