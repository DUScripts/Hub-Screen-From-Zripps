
entries = {
    {"B Assemblers", "resources_generated/elements/industries/industry-assembly_001/icons/env_industry-assembly_001_icon.png"},
    {"B Industry Units", "resources_generated/elements/industries/industry-metalwork_001/icons/env_industry-metalwork_001_icon.png"},
    {"U Assemblers", "resources_generated/elements/industries/industry-assembly_001/icons/env_industry-assembly_001_icon.png"},
    {"U Industry Units", "resources_generated/elements/industries/industry-metalwork_001/icons/env_industry-metalwork_001_icon.png"},
    {"A Assemblers", "resources_generated/elements/industries/industry-assembly_001/icons/env_industry-assembly_001_icon.png"},
    {"A Industry Units", "resources_generated/elements/industries/industry-metalwork_001/icons/env_industry-metalwork_001_icon.png"},
    {"Scanner", "resources_generated/iconsLib/elementslib/territoryscanner.png"},
    {"B Containers", "resources_generated/elements/containers/container_001_xl/icons/env_container_001_xl_icon.png"},
    {"Transfer", "resources_generated/elements/industries/industry-transfer-unit_001/icons/env_industry-transfer-unit_001_icon.png"},
    {"U Containers", "resources_generated/elements/containers/container_001_xl/icons/env_container_001_xl_icon.png"},
    {"Hub", "resources_generated/elements/containers/container-hub_001/icons/env_container-hub_001_icon.png"},
    {"A Containers", "resources_generated/elements/containers/container_001_xl/icons/env_container_001_xl_icon.png"},
}


local rx, ry = getResolution()
local sizeX = 80
local sizeY = sizeX
local backgroundColor = { r = 13 / 255, g = 24 / 255, b = 28 / 255 }
local TextColor = { r = 13 * 3 / 255, g = 24* 3 / 255, b = 28* 3 / 255 }
local blueColor = { r = 200 / 255, g = 200 / 255, b = 200 / 255 }
--local blueColor = { r = 26 / 255, g = 174 / 255, b = 255 / 255 }
local shadowColor = { r = 41 / 255, g = 52 / 255, b = 255 / 255 }
local edgeGap = 30
local edgeRadius = 60
local layer = createLayer()
local font = loadFont('Play', 25)
local fontS = loadFont('Play', 120)
local HudOffset = 95
local StartAtY = 82

local scale = 1

local mfloor = math.floor

function drawQuickImage (url, posX, posY)
    local img = loadImage(url)
    local layer = createLayer()
    addImage(layer, img, posX-(sizeX/2), posY-(sizeY/2), sizeX, sizeY)
end
  
local cyanColor = { r = 135 / 255, g = 206 / 255, b = 235 / 255 }
local backgroundColor = { r = 13 / 255, g = 24 / 255, b = 28 / 255 }
setBackgroundColor(backgroundColor.r, backgroundColor.g, backgroundColor.b)
local layer = createLayer()
setNextFillColor(layer, 0, 0, 0, 0)
setNextStrokeColor(layer, cyanColor.r, cyanColor.g, cyanColor.b, 1)
setNextStrokeWidth(layer, 0.1)
addBox(layer, 5, 5, rx - 10, ry - 10)


function drawFrame(x, y, scale)    
    
      setDefaultStrokeColor(layer, Shape_Line, blueColor.r, blueColor.g, blueColor.b, 1)    
      setDefaultStrokeWidth(layer, Shape_Line, 0.01)
      setDefaultShadow(layer, Shape_Line, 3, shadowColor.r, shadowColor.g, shadowColor.b, 0.5)
    
      addLine(layer, x - (80 * scale), y - (40 * scale), x + (80 * scale), y - (40 * scale))    
      addLine(layer, x + (80 * scale), y - (40 * scale), x + (90 * scale), y - (25 * scale))    
      addLine(layer, x + (90 * scale), y - (25 * scale), x + (90 * scale), y + (25 * scale))    
      addLine(layer, x + (90 * scale), y + (25 * scale), x + (80 * scale), y + (40 * scale))    
      addLine(layer, x + (80 * scale), y + (40 * scale), x - (80 * scale), y + (40 * scale))    
      addLine(layer, x - (80 * scale), y + (40 * scale), x - (90 * scale), y + (25 * scale))
      addLine(layer, x - (90 * scale), y + (25 * scale), x - (90 * scale), y - (25 * scale))    
      addLine(layer, x - (90 * scale), y - (25 * scale), x - (80 * scale), y - (40 * scale))         
end

function drawBlock(text, url, x, y, right)
  if string.len(text) > 0 then
    drawFrame (x, y, 1)
    drawFrame (x, y, 1.05)  
  end
    setNextFillColor(layer, TextColor.r, TextColor.g, TextColor.b, 1)
    if right then
      setNextTextAlign(layer, AlignH_Left, AlignV_Middle)
      addText(layer, font, text, x + 110, y) 
      drawQuickImage(url, rx - (sizeX/2) - 15, y)
    else
      setNextTextAlign(layer, AlignH_Right, AlignV_Middle)
      addText(layer, font, text, x - 110, y) 
      drawQuickImage(url, (sizeX/2) + 15, y)
    end
end

for id, line in ipairs  (entries) do 
    local right = id % 2 == 0
    
    local ly = StartAtY +(96 * (mfloor((id-1) / 2)))
    local lx = rx / 2 - HudOffset
    if right then
        lx = rx / 2 + HudOffset
    end
    
    drawBlock(line[1], line[2], lx, ly, right)   
    
    if entries[id + 2] and string.len(line[1]) > 0 then  
        if right then
           addLine(layer, rx / 2 + 50, ly + (96 / 2), rx - 50, ly + (96 / 2)) 
        else            
           addLine(layer, 50, ly + (96 / 2), rx / 2 - 50, ly + (96 / 2)) 
        end
    end
end    

addLine(layer, rx / 2, 20, rx / 2, ry - 20) 
