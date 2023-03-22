local pixelcode = [[
    uniform float dt;

    vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
    {
        vec4 texcolor = Texel(tex, texture_coords);
        vec3 col = 0.5 + 0.5*cos(dt + texture_coords.xyx + vec3(0,2,4));

        return vec4(col,texcolor.a);
    }
]]


function love.load()
    speed = 100
    height = love.graphics.getHeight()
    width = love.graphics.getWidth()
    x = love.math.random(1, width - 1)
    y = love.math.random(1, height - 1)
    direction = "rightdown"

    shader = love.graphics.newShader(pixelcode)
    dvdTexture = love.graphics.newImage("dvd.png")
    dvdTextureWidth = dvdTexture:getWidth()
    dvdTextureHeight = dvdTexture:getHeight()
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    shader:send("dt", love.timer.getTime())



    if direction == "rightdown" then
        x = math.floor(x + dt * speed)
        y = math.floor(y + dt * speed)
    elseif direction == "rightup" then
        x = math.floor(x + dt * speed)
        y = math.floor(y - dt * speed)
    elseif direction == "leftdown" then
        x = math.floor(x - dt * speed)
        y = math.floor(y + dt * speed)
    elseif direction == "leftup" then
        x = math.floor(x - dt * speed)
        y = math.floor(y - dt * speed)
    end

    if x >= width - dvdTextureWidth then
        if direction == "rightup" then
            direction = "leftup"
        else
            direction = "leftdown"
        end
    elseif x <= 0 then
        if direction == "leftup" then
            direction = "rightup"
        else
            direction = "rightdown"
        end
    end

    if y >= height - dvdTextureHeight then
        if direction == "rightdown" then
            direction = "rightup"
        else
            direction = "leftup"
        end
    elseif y <= 0 then
        if direction == "leftup" then
            direction = "leftdown"
        else
            direction = "rightdown"
        end
    end
end

function love.draw()
    love.graphics.setShader(shader)
    love.graphics.draw(dvdTexture, x, y)
    love.graphics.setShader()
end

function love.resize(newWidth, newHeight)
    width = newWidth
    height = newHeight
end