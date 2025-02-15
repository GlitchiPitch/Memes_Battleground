local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = {
    BattlegroundSystem = ReplicatedStorage.BattlegroundSystem,
    UnitSystem = ReplicatedStorage
}

local function initialize()
    for _, module in Modules do
        require(module).initialize()
    end
end

initialize()