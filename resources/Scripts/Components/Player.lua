Player = {}
Player.__index = Player

setmetatable(Player, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function Player.new(speed, hasDynamite, timer)
    local self = setmetatable({}, Player)
    self.speed = speed or 0.0
    self.hasDynamite = hasDynamite or false
    self.timer = timer or 0.0
    return self
end