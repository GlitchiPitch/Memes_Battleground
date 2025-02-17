local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local Data = require(ServerStorage.Data)

local function onPlayerAdded(player: Player)
    Data.get(player)
end

local function onPlayerRemoving(player: Player)
    Data.post(player)
end

local function initialize() 
    Players.PlayerAdded:Connect(onPlayerAdded)
    Players.PlayerRemoving:Connect(onPlayerRemoving)
end

return {
	initialize = initialize,
}
