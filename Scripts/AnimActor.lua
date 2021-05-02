AnimActor = Actor:extend()

function AnimActor:new(x, y, speed, dimx, dimy, fx, fy, g)
  AnimActor.super.new(self, x, y, dimx, dimy)
  self.forward = Vector.new(fx or 1, fy or 0)
  self.speed = speed or 30
  self.grav = g or 0
end

function AnimActor:update(dt)
  self.position = self.position + self.forward * self.speed * dt
end

function AnimActor:draw()
end
