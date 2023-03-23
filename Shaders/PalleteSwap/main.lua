--Alien sprite by https://opengameart.org/content/alien-sprite-0

shaderCode = [[
    uniform Image palette;
    uniform bool usepalette;

    vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
    {
        vec4 texcolor = Texel(tex, texture_coords);
        vec4 palettecolor = Texel(palette, vec2(texcolor.g, 0));

        if(usepalette == true){
            return vec4(palettecolor.rgb, texcolor.a);
        }else{
            return texcolor;
        }

    }
]]

usepalete = false

function love.load()
    love.graphics.setDefaultFilter("nearest")
    shader = love.graphics.newShader(shaderCode)
    palette = love.graphics.newImage("pallete.png")
    image = love.graphics.newImage("alien.png")
    shader:send("palette", palette)
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("space") then
        if usepalete == false then
            usepalete = true
        else
            usepalete = false
        end
        shader:send("usepalette", usepalete)
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.setShader(shader)
    love.graphics.draw(image, 0, 0, 0, 10, 10)
    love.graphics.setShader()
end
