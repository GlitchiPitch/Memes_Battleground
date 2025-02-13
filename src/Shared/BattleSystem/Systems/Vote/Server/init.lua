local Server = script.Parent
local Systems = Server.Parent
local BattleSystem = Systems.Parent

local Utility = BattleSystem.Utility
local Events = BattleSystem.Events

local Constants = require(BattleSystem.Constants)
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

return startVote