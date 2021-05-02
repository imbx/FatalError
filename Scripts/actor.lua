Actor = Object:extend()

function Actor:new(x, y, dimx, dimy)
  self.position = Vector.new(x or 0, y or 0)
  self.scale = Vector.new(1, 1)
  self.rot = 0
  self.origin = Vector.new(0.5, 0.5)
  self.size = Vector.new(dimx or 0, dimy or 0)
end

function Actor:update(dt)
end

function Actor:draw()
end

function Actor:setPos(x, y)
  self.position.x = x
  self.position.y = y
end

function Actor.dist(a, b)
  v = b.position - a.position
  return v:len()
end

function Actor.intersect(a, b)
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
