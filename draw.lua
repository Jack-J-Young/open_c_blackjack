local component = require("component")
local gpu = component.gpu

function line(x1, y1, x2, y2)
  gpu.setBackground(0xffffff)
  local m = (y2-y1)/(x2-x1)
  local c = (y1-m*x1)
  local y = m*math.min(x1, x2)+c
  for x = math.min(x1, x2), math.max(x1, x2), 1 do
    if (m*x+c - y > math.abs(1)) then
      local s = m/math.abs(m)
      for iy = y + s, m*x+c, s do
        gpu.set(x, iy, " ")
      end
    end
    y = m*x+c
    gpu.set(x, y, " ")
  end
  gpu.setBackground(0x000000)
end

function ellipse(x, y, w, h)
  gpu.setBackground(0xffffff)
  for iy = y-h/2, y+h/2, 1 do
    for ix = x-w/2, x+w/2, 1 do
      if (math.sqrt(math.pow(x-ix) + math.pow(h/w*(y-iy))) < w/2) then
        gpu.set(ix, iy, " ")
      end
    end
  end
  gpu.setBackground(0x000000)
end

gpu.fill(1,1,100,50, " ")
ellipse(50, 25, 50, 25)
os.sleep(5)

local f = 1

for i = 0, 400, 1 do
  gpu.fill(1,1,100,50, " ")
  f = f + 1
  if (f > 40) then
    f = 1
  end
  line(2,25, 90, f)
  os.sleep(0.0001)
end
