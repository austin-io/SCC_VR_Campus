require "math"
require "room"

local sky = {}
local mat = {}
local rooms = {}
local _currentRoom = {}

function lovr.load()
    --sky = lovr.graphics.newTexture("assets/skybox.hdr")
    
    rooms[1] = Room:new("assets/skybox.hdr", "Field")
    rooms[2] = Room:new("assets/snow.hdr", "Snow")
    rooms[3] = Room:new("assets/trail.hdr", "Trail")
    rooms[4] = Room:new("assets/castle.hdr", "Castle")
    rooms[5] = Room:new("assets/restaurant.hdr", "Restaurant")

    rooms[1].addRooms({rooms[2], rooms[3], rooms[5]},{0, math.pi, math.pi/2})
    rooms[2].addRooms({rooms[1], rooms[4]},{0, math.pi})
    rooms[3].addRooms({rooms[1], rooms[5]},{0, math.pi})
    rooms[4].addRooms({rooms[2], rooms[5]},{0, math.pi})
    rooms[5].addRooms({rooms[3], rooms[4]},{0, math.pi})

    changeRoom(rooms[1])

    --[[{
      mat = lovr.graphics.newMaterial()
      mat:setColor("diffuse", 0.8,0.5,1,1)

      shader = lovr.graphics.newShader('standard', {
          flags = {
            normalMap = false,
            indirectLighting = true,
            occlusion = true,
            emissive = true,
            skipTonemap = false
          }
        })

      shader:send('lovrLightDirection', { -1, -1, -1 })
      shader:send('lovrLightColor', { .9, .9, .8, 1.0 })
      shader:send('lovrExposure', 2)

      --lovr.graphics.setBackgroundColor(.18, .18, .20)
      lovr.graphics.setCullingEnabled(true)
      lovr.graphics.setBlendMode()
    }]]
end

function lovr.draw()

    _currentRoom.draw()

    -- Add lighting
    --lovr.graphics.setShader(shader)
    
    --lovr.graphics.cube(mat, 3,3,-3,1,0)

    -- Reset shader mode
    --lovr.graphics.setShader()

    --lovr.graphics.skybox(sky)
end

function changeRoom(r)
  _currentRoom = r
end