local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = {
    BattlegroundSystem = ReplicatedStorage.BattlegroundSystem,
}

local function initialize()
    for _, module in Modules do
        require(module).initialize()
    end
end

initialize()