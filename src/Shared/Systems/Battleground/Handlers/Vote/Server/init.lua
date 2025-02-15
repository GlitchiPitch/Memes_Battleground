local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoteHandler = script.Parent
local Variables = VoteHandler.Variables

local Handlers = VoteHandler.Parent
local BattlegroundSystem = Handlers.Parent

local Utility = ReplicatedStorage.Utility
local Events = BattlegroundSystem.Events

local Types = require(BattlegroundSystem.Types)
local Constants = require(BattlegroundSystem.Constants)
local checkValidPlayers = require(Utility.checkValidPlayers)
local notificationPlayers = require(Utility.notificationPlayers)
local clearConnections = require(Utility.clearConnections)

local event = Events.Event
local eventActions = require(event.Actions)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local _connections: { RBXScriptConnection } = {}
local _battleData: Types.BattleDataType
local votes: { [Types.DifficultType]: number } = {
    Easy = 0,
    Medium = 0,
    Hard = 0,
}

local function startVote(players: { Player })
    for i = Constants.VOTE_TIME, 0, -1 do
        task.wait(1)
        checkValidPlayers(players)
        notificationPlayers(players, remoteActions.vote, i)
    end
end

local function finishVote()
    clearConnections(_connections)
    Variables.VotedPlayersCount.Value = 0
    _battleData = {}
    votes = {
        Easy = 0,
        Medium = 0,
        Hard = 0,
    }
    event:Fire(eventActions.startPlacement)
end

local function checkStartGame()
    if Variables.VotedPlayersCount.Value == #_battleData.Teams[Constants.DEFAULT_TEAM].Players then
        finishVote()
    end
end

local function vote(player: Player, difficult: Types.DifficultType)
    if not player:GetAttribute(Constants.VOTED_PLAYER_ATTRIBUTE) then
        player:SetAttribute(Constants.VOTED_PLAYER_ATTRIBUTE, true)
        votes[difficult] += 1
        Variables.VotedPlayersCount.Value += 1
        checkStartGame()
    end
end

local function remoteConnect(player: Player, action: string, ...: any)
    local actions = {
        [remoteActions.vote] = vote,
    }

    if actions[action] then
       actions[action](player, ...) 
    end
end

local function setup()
    table.insert(
        _connections,
        remote.OnServerEvent:Connect(remoteConnect)
    )
end

local function initialize(battleData: Types.BattleDataType)
    _battleData = battleData
    setup()
    startVote(battleData.Teams[Constants.DEFAULT_TEAM].Players)
end

return {
    initialize = initialize,
}