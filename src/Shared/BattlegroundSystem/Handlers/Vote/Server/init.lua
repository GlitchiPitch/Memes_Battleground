local VoteHandler = script.Parent
local Handlers = VoteHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Utility = BattlegroundSystem.Utility
local Events = BattlegroundSystem.Events

local Constants = require(BattlegroundSystem.Constants)
local checkValidPlayers = require(Utility.checkValidPlayers)

local battleSystemRemote = Events.Remote

local function startTimer()
    for _ = Constants.VOTE_TIME, 0, -1 do
        task.wait(1)
    end
end

local function startVote()
    startTimer()
end

return {
    startVote = startVote,
}