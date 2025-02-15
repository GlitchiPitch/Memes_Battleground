local RunService = game:GetService("RunService")
if RunService:IsServer() then
    return
elseif RunService:IsClient() then
    return
end