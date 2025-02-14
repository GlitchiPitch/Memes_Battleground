local function clearConnections(_connections: { RBXScriptConnection })
    for _, connect in _connections do
        connect:Disconnect()
    end
end

return clearConnections