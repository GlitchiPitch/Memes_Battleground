local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Systems = ReplicatedStorage.Systems

local Modules = {
    Battleground = Systems.Battleground,
    Units = Systems.Units,
}

local function initialize()
    for _, module in Modules do
        require(module).initialize()
    end
end

initialize()