PlayerDynamite = {}
PlayerDynamite.__index = PlayerDynamite

setmetatable(PlayerDynamite, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function PlayerDynamite.new()
    local self = setmetatable({}, PlayerDynamite)
    return self
end
