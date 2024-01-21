DestroyableParticle = {}
DestroyableParticle.__index = DestroyableParticle

setmetatable(DestroyableParticle, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function DestroyableParticle.new(lifetime, timer)
    local self = setmetatable({}, DestroyableParticle)
    self.lifetime = lifetime or 0.0
    self.timer = timer or 0.0
    return self
end
