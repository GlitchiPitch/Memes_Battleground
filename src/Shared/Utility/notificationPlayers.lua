local Utility = script.Parent
local BattlegroundSystem = Utility.Parent
local Events = BattlegroundSystem.Events

local remote = Events.Remote

local function notificationPlayers(playerList: { Player }, action: string, ...: any)
    for _, player in playerList do
        remote:FireClient(player, action, ...)
    end
end

return notificationPlayers