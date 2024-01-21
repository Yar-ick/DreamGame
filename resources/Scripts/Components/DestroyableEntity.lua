DestroyableEntity = {}
DestroyableEntity.__index = DestroyableEntity

setmetatable(DestroyableEntity, {
    __call = function (self, ...)
        return self.new(...)
    end
})

function DestroyableEntity.new()
    local self = setmetatable({}, DestroyableEntity)
    return self
end
