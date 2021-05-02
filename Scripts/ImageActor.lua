ImgActor = AnimActor:extend()

function ImgActor:new(image, x, y, speed, fx, fy, g)
  ImgActor.super.new(self, x, y, speed, 0, 0, fx, fy, g)
  self.image = love.graphics.newImage(image or "Textures/background.jpg")
  self.size.y = self.image:getHeight()
  self.size.x = self.image:getWidth()
end

function ImgActor:update(dt)
  self.position = self.position + self.forward * self.speed * dt
end

function ImgActor:draw()
end

function ImgActor.dist(a, b)
  v = b.position - a.position
  return v:len()
end


function ImgActor.intersect(a, b)
  --With locals it's common usage to use underscores instead of camelCasing
  local ax = a.position.x
  local ay = a.position.y
  local aw = a.size.x
  local ah = a.size.y

  local bx = b.position.x
  local by = b.position.y
  local bw = b.size.x
  local bh = b.size.y

  if ax + aw > bx and ax < bx + bw and ay + ah > by and ay < by + bh then
    return true
  else
    return false
  end
end
