-- Script automático de força para Dumbell no jogo Cobra Kai Karat

local player = game:GetService("Players").LocalPlayer
local dumbell = player.Character:FindFirstChild("Dumbell")

if dumbell and dumbell:FindFirstChild("Event") then
    while true do
        -- Configura o valor para +100 de força
        local args = {
            [1] = 100
        }

        -- Dispara o evento de ganhar força
        dumbell.Event:FireServer(unpack(args))

        -- Espera exatamente 1 segundo antes de clicar de novo
        task.wait(1)
    end
else
    warn("Dumbell ou o evento não foram encontrados!")
end
