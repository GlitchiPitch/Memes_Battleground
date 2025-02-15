local VoteHandler = script.Parent
local Handlers = VoteHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Utility = BattlegroundSystem.Utility
local Events = BattlegroundSystem.Events

local Types = require(BattlegroundSystem.Types)
local Constants = require(BattlegroundSystem.Constants)
local checkValidPlayers = require(Utility.checkValidPlayers)
local notificationPlayers = require(Utility.notificationPlayers)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local function startTimer()
    
end

local function startVote(players: { Player })
    for i = Constants.VOTE_TIME, 0, -1 do
        task.wait(1)
        checkValidPlayers(players)
        notificationPlayers(players, remoteActions.vote, i)
    end
end

local function initialize(battleData: Types.BattleDataType)
    startVote(battleData.Players)
    startTimer()
end

return {
    initialize = initialize,
}