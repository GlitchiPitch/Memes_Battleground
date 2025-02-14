local BaseUnit = {}
BaseUnit.__index = BaseUnit

type UnitModel = Model & { Humanoid: Humanoid }
type BaseUnitType = {
    name: string,
    model: UnitModel,
    stats: {},
}


function BaseUnit.new() : BaseUnitType
    local self = {}
    self.name = ""
    self.model = nil
    self.stats = {}
    return setmetatable(self, BaseUnit)
end

BaseUnit.checkValidAct = function(callback: () -> ())
    return callback()
end

BaseUnit.Act = function(self: BaseUnitType)
    if self:checkValidAct() then
        
    end
end

BaseUnit.Move = function(self: BaseUnitType, targetPosition: Vector3)
    local humanoid = self.model.Humanoid
    humanoid:MoveTo(targetPosition)
end

BaseUnit.Died = function(self: BaseUnitType)
    -- breakJoints()
    self.model:Destroy()
end

return BaseUnit