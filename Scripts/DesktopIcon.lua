DesktopIcon = Actor:extend()

function DesktopIcon:new(x, y, name, img)
  DesktopIcon.super.new(self, x, y, 32, 32)
  self.name = name or "(Untitled)"
  self.image = love.graphics.newImage(img or "Textures/bdi.png")
  self.isClicked = false
end

function DesktopIcon:update(dt)
end

function DesktopIcon:draw()
  local hx = (self.size.x * self.origin.x)
  local hy = (self.size.y * self.origin.y)
  local vx = (self.position.x - self.size.x) + (self.size.x * 2) - 1
  local vy = (self.position.y - hy - 6) + (self.size.y * 2) - 1

  if self.isClicked then
    love.graphics.setColor(0, 0.06, 0.5)
    love.graphics.rectangle("fill", self.position.x - self.size.x, self.position.y + hy + 4, (self.size.x * 2), hy)
  end

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.image, self.position.x - hx, self.position.y - hy)
  love.graphics.printf(self.name, self.position.x - self.size.x, self.position.y + hy + 4, self.size.x * 2, "center")

  if self.isClicked then
    love.graphics.setColor(0, 0.06, 0.5, 0.75)
    love.graphics.draw(self.image, self.position.x - hx, self.position.y - hy)
  end
  love.graphics.setColor(1, 1, 1)
end

function DesktopIcon:CheckPos(mpos)
  if mpos.x > self.position.x - self.size.x and mpos.x < self.position.x + self.size.x and mpos.y > self.position.y - (self.size.y * self.origin.y) and mpos.y < self.position.y + (self.size.y * self.origin.y) + 4 + (self.size.y * self.origin.y) then
    return true
  end
  return false
end
