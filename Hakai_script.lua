--BY HAKAI_OFC VIDA MOBILE
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local BridgeNet = require(Modules:WaitForChild("BridgeNet2"))
local pullUpRemote = BridgeNet.ReferenceBridge("imadumbexploiter3527d36bd7d656f96a836f1df5085590")
local ENVIO_POR_FRAME = 1500
RunService.Heartbeat:Connect(function()
    for i = 1, ENVIO_POR_FRAME do
        pullUpRemote:Fire()
    end
end)
