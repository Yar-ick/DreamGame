CollectableTNT = {}
CollectableTNT.__index = CollectableTNT

setmetatable(CollectableTNT, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function CollectableTNT.new()
    local self = setmetatable({}, CollectableTNT)
    return self
end
