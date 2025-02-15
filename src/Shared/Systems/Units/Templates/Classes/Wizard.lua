local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local boostList = {
    ""
}

local effectList = {
    ""
}

local function getMagnitude(unit1: Model, unit2: Model)
    return (unit1:GetPivot().Position - unit2:GetPivot().Position).Magnitude
end

local WizardClass = {}
WizardClass.__index = WizardClass

type UnitStatsFolder = Folder & {
    Target: ObjectValue,
    
}

type WizardClassType = typeof(WizardClass) & {
    model: Model & { Humanoid: Humanoid },
    name: string,
    stats: UnitStatsFolder,
    configuration: {
        targetDistance: number,
        spellDistance: number,
        evadeChance: number,
        magicInstance: BasePart,
        magicSpeed: number,
    },
    animations: { 
        attack: number | AnimationTrack,
        die: number | AnimationTrack,
    },
    boosts: { [string]: number },
    effects: { [string]: number },
}

function WizardClass.new() : WizardClassType
    local self = {}
    self.model = nil :: Model
    self.name = "" :: string
    self.stats = Instance.new("Folder") :: UnitStatsFolder -- StatsFolder:Clone()
    self.configuration = {
        targetDistance = 10,
        spellDistance = 10,
        evadeChance = 1,
        magicInstance = Instance.new("Part"),
        magicSpeed = 100,
    }

    self.animations = {
        attack = 0,
    }

    self.boosts = {}
    self.effects = {}
    return setmetatable(self, WizardClass)
end

WizardClass.checkValidAct = function(self: WizardClassType)
    for _, effect in effectList do
        if self.effects[effect] then
            return false
        end
    end

    return true
end

WizardClass.findTarget = function(self: WizardClassType, enemyUnits: { Model }) -- or { classes }
    if not self.stats.Target.Value then
        for _, enemy in enemyUnits do
            if self.configuration.targetDistance < getMagnitude(enemy, self.model) then
                self.stats.Target.Value = enemy
                break
            end
        end
    end
end

WizardClass.attack = function(self: WizardClassType)
    local enemy = self.stats.Target.Value :: Model
    local function spellMagic()
        self.animations.attack:Play()
        -- task.wait(self.animations.attack.Length)
        local magicInstance = self.configuration.magicInstance:Clone()
        local distance = getMagnitude(enemy, self.model)
        local tweenTime = distance / self.configuration.magicSpeed
        local tweenInfo = TweenInfo.new(tweenTime)
        magicInstance.Parent = self.model
        local tween = TweenService:Create(magicInstance, tweenInfo, {CFrame = enemy:GetPivot()})
        tween:Play()
        
    end

    if enemy then
        if self.configuration.spellDistance < getMagnitude(enemy, self.model) then
            spellMagic()
        end
    end

    print(self.name, "Attack")
end

WizardClass.loadAnimation = function(self: WizardClassType)
    local humanoid = self.model.Humanoid
    local animator = humanoid:FindFirstChildOfClass("Animator")
    for animName, animationId in self.animations do
        local animation = Instance.new("Animation")
        animation.AnimationId = animationId
        self.animations[animName] = animator:LoadAnimation(animation)
    end
end

WizardClass.initialize = function(self: WizardClassType)
    self:loadAnimation()
end

local ShrekWizard = {}
ShrekWizard.__index = ShrekWizard

function ShrekWizard.new()
    local self = WizardClass.new()
    self.name = "ShrekWizard"

    return setmetatable(self, ShrekWizard)
end

local SigmaWizard = {}
SigmaWizard.__index = SigmaWizard

function SigmaWizard.new()
    local self = WizardClass.new()
    self.name = "SigmaWizard"
    return setmetatable(self, SigmaWizard)
end

local shrekWizard = ShrekWizard.new()
shrekWizard:attack()

local sigmaWizard = SigmaWizard.new()
sigmaWizard:attack()