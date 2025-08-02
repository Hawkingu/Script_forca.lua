--BY HAKAI_OFC FORÇA MOBILE
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local BridgeNet = require(Modules:WaitForChild("BridgeNet2"))
local remote = BridgeNet.ReferenceBridge("imadumbexploiter9d7f88729c2c6ceff3bb1ce223049848")
local ENVIO_POR_FRAME = 1500
local INTERVALO = 0.000001
while task.wait(INTERVALO) do
    for i = 1, ENVIO_POR_FRAME do
        remote:Fire()
    end
end
