local Players = game:GetService("Players")
local BattleHandler = script.Parent
local Handlers = BattleHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Events = BattlegroundSystem.Events
local battleSystemRemote = Events.Remote

local Types = require(BattlegroundSystem.Types)

local function prepare(players: { Player })
    for _, player in Players do
        battleSystemRemote:FireClient(player)
    end
end

local function startBattle(battleData: Types.BattleDataType)
    prepare(battleData.Players)
end

return {
    startBattle = startBattle,
}