PlayerStart = {}
PlayerStart.__index = PlayerStart

setmetatable(PlayerStart, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function PlayerStart.new()
    local self = setmetatable({}, PlayerStart)
    return self
end
