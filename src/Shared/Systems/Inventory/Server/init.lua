local InventorySystem = script.Parent
local Functions = InventorySystem.Functions

local bindableFunction = Functions.Bindable
local bindableFunctionActions = require(bindableFunction.Actions)

local function getPlayerUnit(player: Player, unitId: string)
    
end

local function bindableFunctionInvoke(action: string, ...: any)
    local actions = {
        [bindableFunctionActions.getPlayerUnit] = getPlayerUnit,
    }

    if actions[action] then
        return actions[action](...)
    end
end

local function initialize()
   bindableFunction.OnInvoke = bindableFunctionInvoke
end

return {
    initialize = initialize,
}