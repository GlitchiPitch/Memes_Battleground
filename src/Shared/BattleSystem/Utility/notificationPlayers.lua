local Utility = script.Parent
local BattleSystem = Utility.Parent
local Events = BattleSystem.Events

local battleSystemRemote = Events.Remote

local function notificationPlayers(playerList: { Player })
    for _, player in playerList do
        battleSystemRemote:FireClient(player)
    end
end

return notificationPlayers