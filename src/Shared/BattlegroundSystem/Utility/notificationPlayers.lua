local Utility = script.Parent
local BattlegroundSystem = Utility.Parent
local Events = BattlegroundSystem.Events

local battleSystemRemote = Events.Remote

local function notificationPlayers(playerList: { Player })
    for _, player in playerList do
        battleSystemRemote:FireClient(player)
    end
end

return notificationPlayers