local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Utility = ReplicatedStorage.Utility

local Types = require(ReplicatedStorage.Types)
local getMagnitude = require(Utility.getMagnitude)

type BaseUnitType = Types.UnitType

local UnitClass = {}
UnitClass.__index = UnitClass

function UnitClass.new() : BaseUnitType
    local self = {}
    self.Model = nil
    self.Name = nil
    self.Stats = {
        XP = 0,
        Level = 0,
        HP = 0,
    }
    self.Animations = {
        attack = 0,
    }

    self.Effects = {}

    self.Configuration = {
        Damage = 0,
        Evade = 0,
        Knockback = 0,
        StealHealth = 0,
        Freeze = 0,
        BloodFlood = 0,
        EvadeChance = 0,
        FreezeChance = 0,
        KnockbackChance = 0,
        StealHealthChance = 0,
        BloodFloodChance = 0,
        AttackDistance = 0,
        CurrentTarget = nil,
    }

    return setmetatable(self, UnitClass)
end

UnitClass.Act = function(self: BaseUnitType, enemies: { BaseUnitType })
    if not self:CanBattle() then return end
    if not self.Configuration.CurrentTarget then
        self:FindTarget(enemies)
    else
        if self:CanAttack() then
            self:Attack()
        else
            self:Move()
        end
    end
end

UnitClass.CanBattle = function(self: BaseUnitType) : boolean
    return self.Model.Humanoid.Health > 0 and not self.Effects[Types.EffectKeys.Freezed]
end

UnitClass.CanAttack = function(self: BaseUnitType)
    local distance = getMagnitude(self.Configuration.CurrentTarget.Model, self.Model)
    return distance <= self.Configuration.AttackDistance
end

UnitClass.Move = function(self: BaseUnitType)
    local humanoid = self.model.Humanoid
    local targetPosition = self.Configuration.CurrentTarget.Model:GetPivot().Position
    humanoid:MoveTo(targetPosition)
end

UnitClass.Attack = function(self: BaseUnitType)
    -- implement from another unit classes
end

UnitClass.FindTarget = function(self: BaseUnitType, enemies: { BaseUnitType }) : nil
    local target = enemies[math.random(#enemies)] :: Model
    self.Configuration.CurrentTarget = target
end

UnitClass.Died = function(self: BaseUnitType)
    -- breakJoints()
    self.model:Destroy()
    print("Died")
end

UnitClass.Initialize = function(self: BaseUnitType)

    local humanoid = self.Model.Humanoid
    local function onDied()
        self:Died()
    end

    for animName, animId in self.Animations do
        local animation = Instance.new("Animation")
        local animator = self.Model.Humanoid:FindFirstChildOfClass("Animator") :: Animator
        animation.AnimationId = animId
        self.Animations[animName] = animator:LoadAnimation(animation)
    end

    humanoid.Died:Connect(onDied)
end

return UnitClass