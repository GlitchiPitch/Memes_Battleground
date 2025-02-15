local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Types)

local Utility = ReplicatedStorage.Utility
local clearConnections = require(Utility.clearConnections)

local PlacementHandler = script.Parent
local Variables = PlacementHandler.Variables

local Handlers = PlacementHandler.Parent
local BattlegroundSystem = Handlers.Parent
local Events = BattlegroundSystem.Events
local BattlegroundVariables = BattlegroundSystem.Variables

local Constants = require(BattlegroundSystem.Constants)

local remote = Events.Remote
local remoteActions = require(remote.Actions)

local event = Events.Event
local eventActions = require(event.Actions)

local _connections: { RBXScriptConnection } = {}
local _battleData: Types.BattleDataType

local function spawnEnemies(enemies: { Types.UnitType })
    for _, enemyData in enemies do
        table.insert(
            _battleData.Teams[Constants.DEFAULT_ENEMY_TEAM].Units,
            enemyData
        )
        enemyData.Model.Parent = _battleData.Map.Units[Constants.DEFAULT_ENEMY_TEAM]
    end
end

local function startPlacement()

    if _battleData.Mode ~= "Versus" then
        spawnEnemies(_battleData.Map.Waves[BattlegroundVariables.CurrentWave.Value])
    end

    for _, team: Types.TeamType in _battleData.Teams do
        if #team > 0 then
            for _, player in team.Players do
                remote:FireClient(player, remoteActions.startPlacement)
            end
        end
    end
end

local function finishPlacement()
    clearConnections(_connections)
    _battleData = {}
    event:Fire(eventActions.startBattle)
end

local function checkFinishPlacement()
    if Variables.ReadyPlayersCount.Value == (#_battleData.Teams.Red + #_battleData.Teams.Blue) then
        finishPlacement()
    end
end

local function playerReady(player: Player)
    if not player:GetAttribute(Constants.PLAYER_READY_ATTRIBUTE) then
        player:SetAttribute(Constants.PLAYER_READY_ATTRIBUTE, true)
        Variables.ReadyPlayersCount.Value += 1
        checkFinishPlacement()
    end
end

local function spawnUnit(player: Player, selectedUnit: Types.UnitType )
    local playerTeam = player:GetAttribute(Constants.PLAYER_TEAM_ATTRIBUTE) :: string
    
    -- check player has unit
    -- can spawn
    -- checkValidArea
    -- 
    table.insert(
        _battleData.Teams[playerTeam].Units,
        selectedUnit
    )

    selectedUnit.Model.Parent = _battleData.Map.Units[playerTeam]
end

local function remoteConnect(player: Player, action: string)
    local actions = {
        [remoteActions.spawnUnit] = spawnUnit,
        [remoteActions.playerReady] = playerReady,
    }

    if actions[action] then
        actions[action](player)
    end
end

local function eventConnect(action: string, ...: any)
    local actions = {
        [eventActions.startPlacement] = startPlacement,
    }

    if actions[action] then
        actions[action](...)
    end
end

local function initialize(battleData: Types.BattleDataType)
    _battleData = battleData
    table.insert(
        _connections,
        remote.OnServerEvent:Connect(remoteConnect)
    )

    table.insert(
        _connections,
        event.Event:Connect(eventConnect)
    )
end

return {
    initialize = initialize,
}