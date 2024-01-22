CollectableTNT = {}
CollectableTNT.__index = CollectableTNT

setmetatable(CollectableTNT, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function CollectableTNT.new(timer, animationUpDirection)
    local self = setmetatable({}, CollectableTNT)
    self.timer = timer or 0.0
    self.animationUpDirection = animationUpDirection or true
    return self
end
